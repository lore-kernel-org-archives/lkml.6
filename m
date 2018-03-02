Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELux9Id8C53vKcLkPW+r+y0cIVFony+ogj+84Zq1N1f5bvrNs0mVDJQeBACqG8fQWbIytC+y
ARC-Seal: i=1; a=rsa-sha256; t=1519980947; cv=none;
        d=google.com; s=arc-20160816;
        b=REYr8CM4TirH62GqKdIo6Vp2dJOCbt0yqpk1zvj1IaLktlDOey3XC08AMEfObfHDVG
         2NCOoArFUEmoawi044fxybv9q4XXd5e6pBIsiMcSamIsWoi/nsWwme8q190bGMP6smFd
         VbPbBKSj/qWqWWZx8OvX6hidLixtKBIEsKROTGDeJGKHF6Lqsj3BIwo1G+BOG9ARmn06
         nJCQxPb8l1WwL4vv8bNV0hwHmd5v6pLVLxCxGAVWEggJN2Qj2Naxe/kwXhbwmDt/EjQj
         Qoo+huAzdN6N4SKBvabKRL9zNdNgAH/1L90+zyd1BO2Cyov29/j7q0qrt674nWu8WJGQ
         wvIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=p2H0+9K05zSha6XjdJ4PnDIb/HJ0Jj3F38eNuk4+51I=;
        b=Xkm23m5HECH3El8o6u1ffS9dXhXDPwSHNftFej9jvav0kJ1hzNAxRG9DCRnTXPd/5k
         FOtz/lF+AR6ERjkle21kqgbcyQCe+UoQNxtXR2dnG3nvrFRoxq0PZMpW1QfUtdfZolGP
         kobJGk/PYR8o1FY7f4fG36I7tFGfcHb+02sjmD49LJZ8aIvKiETxY/fMFLu37bF/s36+
         Z5uElmCHtzhVtwHKxMcrPOf5UHV1Ysneug9b/19NmuqxwPuI3MaCYXdTPmQfAqH26dUg
         3vw4v083nvPv/Y/WjbUNXOpaMtBJdfW5k2n0KAeopTAkHjdwr8laLdHkMlOmxo0hJdyf
         DVxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ross Lagerwall <ross.lagerwall@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 31/34] xen/gntdev: Fix partial gntdev_mmap() cleanup
Date: Fri,  2 Mar 2018 09:51:27 +0100
Message-Id: <20180302084438.008379826@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815402000490514?=
X-GMAIL-MSGID: =?utf-8?q?1593815542078982161?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Lagerwall <ross.lagerwall@citrix.com>


[ Upstream commit cf2acf66ad43abb39735568f55e1f85f9844e990 ]

When cleaning up after a partially successful gntdev_mmap(), unmap the
successfully mapped grant pages otherwise Xen will kill the domain if
in debug mode (Attempt to implicitly unmap a granted PTE) or Linux will
kill the process and emit "BUG: Bad page map in process" if Xen is in
release mode.

This is only needed when use_ptemod is true because gntdev_put_map()
will unmap grant pages itself when use_ptemod is false.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/gntdev.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -874,8 +874,10 @@ unlock_out:
 out_unlock_put:
 	mutex_unlock(&priv->lock);
 out_put_map:
-	if (use_ptemod)
+	if (use_ptemod) {
 		map->vma = NULL;
+		unmap_grant_pages(map, 0, map->count);
+	}
 	gntdev_put_map(priv, map);
 	return err;
 }
