Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELthygo9h18jc5mRSmojRXKcDH+ukSxAP2sLNrjH7IDXtPGO9KDNfgiYz3ivluMY7MaJ7xvX
ARC-Seal: i=1; a=rsa-sha256; t=1519981134; cv=none;
        d=google.com; s=arc-20160816;
        b=yagsKl7k2sgRrdOkBJvDgzxdep5YPlqhHtZzo5CWR5V/K8D+VY/3jTC0/ZhUfSkUPF
         UC9MjM9iCCksCKkKTala4cb4aRr/5Re97rPr73HEoMJbv60Ck6D7DbYmnLDlu1Sb1Hfe
         6tMZsg967sDXAkmEsVqH4zW8NWVlGe69Pru2gFK3ra+HMCtgud2lbjOkl/glA3jm3Bq2
         xa9YaDc7uI5vp+THavsegMt7w7dkamDgOFirvv3UBNemx3gwe588bg1oHKa8MrdBZLFb
         2GMXwJFkdFe66MDntVx2nrat+7AoOQ0JK6x+S6lXYIDasm4dgMwTefjyHr0eMWlervLn
         K86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EtBNJf7r28iYbB5abSQL84uKrK1TEirAiiA4Pr2LPfk=;
        b=EJb13pfvDjkLfIUp2uZDvjOTybz9wncySAkQV2CENG4sRN3qTXlmWo5A7WFDuBJz7P
         LYMqKwyk1gI9bHiAxEYN9yluzwW0Fi0P/ab3mH/HsnhALayDfHMUEDfIeEuxoUlcdw1U
         9hNZLh603TT5M+NFGp6JszCDZAzRzTiDfTv42HMg64Qmdvpx3FcH2PY69AFWy/ceZmYh
         R+lypBtXwP4M5IzvOBSprox3F/0DWoBsjXwMP3GHL0ImdtDijV0Dtovem8TFTsyxNPOT
         fCYPqaLVGW90GTAtEW3NUXQjRZ6XYHz0UxsGsSpDhFxjCzMcYBAJQjRf65P5C1a1eMb2
         cXJw==
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
Subject: [PATCH 4.9 52/56] xen/gntdev: Fix partial gntdev_mmap() cleanup
Date: Fri,  2 Mar 2018 09:51:38 +0100
Message-Id: <20180302084452.166420030@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815402000490514?=
X-GMAIL-MSGID: =?utf-8?q?1593815737464277199?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1077,8 +1077,10 @@ unlock_out:
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
