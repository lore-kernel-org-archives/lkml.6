Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtLyJj2ZrJiPMuAd2/KlX9VXkM1XwVMrg5Gr7QoHtGy2ghlHZZmoCI/fyrCH7hmOfqZ3OLy
ARC-Seal: i=1; a=rsa-sha256; t=1519980944; cv=none;
        d=google.com; s=arc-20160816;
        b=TyBk28zzTtyCqNed9etdZCb3L7cKSGOQqVVynnuZvTzpMTMDEql+hFi7JEOZojc2oR
         QDeLfKMJ20x9toS1iZM+P6jcpLOe3seKp/pRLrhxOZ7/GRN8pUWv8WT0P2Bj50mmzIQ6
         Yc/6GaK/CKLrTlWPxjkMRkbopQGYU90wzI8GtlM5ogdxDSFCmfwCynsJUr3FGv8L175I
         Oe1PM+kC4e43T2k6NZeV8wQbE+/l5O8MnxbVqogIOGckVeWihj9RJBJs544TwaXf+Z/1
         sv6AwsJ//LelA5s89k06vKp1hmdkkrTSDSuVy23bsCrI8WdrYyk7YCiRnZxGar2HgJoh
         I+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XSrNnHqRM9xh0L+iolGLKGwdc1di6TP8Rc2w68lhiPo=;
        b=e/In4oSVRUdU/y65dR8q9TV2sY2BRjTOYujjNbJWoecL2mFf8SwbdI0lfJlRfB1XrV
         LchGLRcOBaejn89+yke91qNKJsU7IeQIRaiI+OdEXhTNgH3Ov0hX9PDEXILDzV3rTT61
         dNtFKeCEL1mbfGPOeZZzdZmlqFeZ4jMzzdMmqlFWvF9DWYHCQNhXKKkHgrgHfA1KLpek
         i3Jv5Pzx0DWmBXxjrX2NjG7rRRnBx9AQdtn94zNDzyE7G5BYbGEL5g46cpZFOBQuvwmQ
         ozH7SZ9MoxCLJmzdq3KMhfZ21QnIZdA6VXUn0icnbzHh5YFlSzQyOvzSQW2xBfyhnjwR
         Wz8Q==
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
Subject: [PATCH 4.4 30/34] xen/gntdev: Fix off-by-one error when unmapping with holes
Date: Fri,  2 Mar 2018 09:51:26 +0100
Message-Id: <20180302084437.935522961@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815399059107290?=
X-GMAIL-MSGID: =?utf-8?q?1593815539023373886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ross Lagerwall <ross.lagerwall@citrix.com>


[ Upstream commit 951a010233625b77cde3430b4b8785a9a22968d1 ]

If the requested range has a hole, the calculation of the number of
pages to unmap is off by one. Fix it.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/gntdev.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -378,10 +378,8 @@ static int unmap_grant_pages(struct gran
 		}
 		range = 0;
 		while (range < pages) {
-			if (map->unmap_ops[offset+range].handle == -1) {
-				range--;
+			if (map->unmap_ops[offset+range].handle == -1)
 				break;
-			}
 			range++;
 		}
 		err = __unmap_grant_pages(map, offset, range);
