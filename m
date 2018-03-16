Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuwKS52OagOkJfKrXVKMBQKz0BJzyX+2Md8779zP1YX4PDTJ5NC5PuS4Myk3XeZ7fiuwIyX
ARC-Seal: i=1; a=rsa-sha256; t=1521214522; cv=none;
        d=google.com; s=arc-20160816;
        b=cBmY4zbqKK6gEn8Iiy2AXBmimqKC34u5J6oMGa0hBwcCTKYWxaRwDA+gpTApIHopy7
         cMFlkNiDFO1MpLzTIpFfVGK9oobTNDf3mq1s584qOyhof+X0FMU3iOyf+PcIKfF3hqCk
         J+w0xt5yN3T6fiTJ4iVw321xFQrtu0C3J6UeyonvT5OC+7+McorXkyubFF5GKCl/JDNv
         l4N3mDK060vCQmEo1GTSAA/8hbPR6bkc/fqqoxvVEzmyUCYBcN6J2gRBmEooyEvYfYL5
         s/F8THpGhZojVGs4XiXPPtkvRDEhRZ96ZURQLl0txVTThvREXCVnFm2i6Ms3u+ZHVjL+
         CDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ImngWB5javFA7da371JltbXxjUyFLUB81ictUSYYnpk=;
        b=ytEuu/q6RJYt2ABIKCctK018TbgdvFNykl2/N3RMeXN/RzA0oIe4VnquiYzyvuV+25
         bn/fdNPcAfw8qYT1IUnPhJ8If/ipY0yrByttSqZTuSijYqIfb7USzTI8t0+wxcHZHyow
         txGM8T3HUyw+c6BG9b99a8aoCbIQe5Na11blpp0ucq5auOc1YXtdgArqAqN69sXRiH38
         sfnVLUCyQasOvre6QF60qUTICdmUHhCR563VooXDifmFdA8oc6YItiqZewLn6ihZkSnp
         2yWk8JMSO0RqcSPfB8fpty2FNXoFrAbo4N+3GJXQkCrQtypQWksdRuynd6sDyYToYyJA
         cJhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 037/109] staging: rtl8822be: fix missing null check on dev_alloc_skb return
Date: Fri, 16 Mar 2018 16:23:06 +0100
Message-Id: <20180316152331.960159777@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109039358682188?=
X-GMAIL-MSGID: =?utf-8?q?1595109039358682188?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit 3eb23426e1749a0483bc4c9b18e51f657569e3ed ]

dev_alloc_skb can potentially return NULL, so add a null check to
avoid a null pointer dereference on skb

Detected by CoverityScan, CID#1454558 ("Dereference on null return")

Fixes: 7e5b796cde7e ("staging: r8822be: Add the driver code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtlwifi/rtl8822be/fw.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/staging/rtlwifi/rtl8822be/fw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/fw.c
@@ -464,6 +464,8 @@ bool rtl8822b_halmac_cb_write_data_rsvd_
 	int count;
 
 	skb = dev_alloc_skb(size);
+	if (!skb)
+		return false;
 	memcpy((u8 *)skb_put(skb, size), buf, size);
 
 	if (!_rtl8822be_send_bcn_or_cmd_packet(rtlpriv->hw, skb, BEACON_QUEUE))
