Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuTCjXH8c9FDL8JoLokNBO0UuJu6BGxXSV+nzAD7DENBSlwkgrCErmaSNX2BnRxSMAih6Qq
ARC-Seal: i=1; a=rsa-sha256; t=1521214154; cv=none;
        d=google.com; s=arc-20160816;
        b=h5bxKUeHVhri+ndM8xu9uugLIbBt86KLEuSO5e+rXuE5seKE4U+S8cui8Fg8M3dQI2
         eHmg7bc+rZOCa8gDOKeTTiMe8rQNVzvyz3rzwFQybZoqLNQSl7CdhuF9zFSVwIuDR4dn
         wA+wGR7Imle3CwzMS9DpJj4A8F08Flcz/KW6sTMuc4m1vyBti9fE5c/hZeUwBTGni24N
         /zryuAuDxAFHDPpLNW2xU9a4OQjGr4UsMz9bm8Lv3EKn6nh9UwT0w/XzFEr4TpcBzNWE
         RnvDOaNqVV1z0fIV3uAX4irryjIBXdSOnRgEU8lF4kVtxU6QgR56zkzJD/no8w7BBKZa
         ENHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cGJzmQjI70G7d28Fv+YUh1yp6YrGS1E/RGJlHl3vqBw=;
        b=klT4DSoMsh4lyMWGry95fkXk+qztIplWf3iN+nXPh9Jp1SczZ8IfSfdLVq4GUaEqKS
         12hahi+S4sqZ8QJTreoY7/lF8i/fnhI16R02JLB1a2jF3MKlSzckhjo+TspL0sZRq6+M
         rASlvlLH2aRTJa3jqWosZHVfi8Z8FRtI/34nyix4ZD2+KQ6xbP/YE3JGTjAUrFvt0GSf
         29yKxFkBHQA8Q1DcyQqPMkzdjAAQZaMM7SiRU8+goTWEhw39+saHMvbodSEQiH91X0jW
         FgHOHE2Kl63UUTp7ZSmTE2B8Wwk20x7Y79avoFa9zL6I3wElRUgpaFrAaQ2O3qY1HOC1
         Q5nw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 4.4 59/63] USB: usbmon: remove assignment from IS_ERR argument
Date: Fri, 16 Mar 2018 16:23:31 +0100
Message-Id: <20180316152306.462072255@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108319813454723?=
X-GMAIL-MSGID: =?utf-8?q?1595108653881503610?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julia Lawall <Julia.Lawall@lip6.fr>

commit 46c236dc7d1212d7417e6fb0317f91c44c719322 upstream.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e1,e2;
statement S1,S2;
@@

+e1 = e2;
if (IS_ERR(
    e1
-   = e2
   )) S1 else S2
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/mon/mon_text.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -386,7 +386,8 @@ static ssize_t mon_text_read_t(struct fi
 	struct mon_event_text *ep;
 	struct mon_text_ptr ptr;
 
-	if (IS_ERR(ep = mon_text_read_wait(rp, file)))
+	ep = mon_text_read_wait(rp, file);
+	if (IS_ERR(ep))
 		return PTR_ERR(ep);
 	mutex_lock(&rp->printf_lock);
 	ptr.cnt = 0;
@@ -413,7 +414,8 @@ static ssize_t mon_text_read_u(struct fi
 	struct mon_event_text *ep;
 	struct mon_text_ptr ptr;
 
-	if (IS_ERR(ep = mon_text_read_wait(rp, file)))
+	ep = mon_text_read_wait(rp, file);
+	if (IS_ERR(ep))
 		return PTR_ERR(ep);
 	mutex_lock(&rp->printf_lock);
 	ptr.cnt = 0;
