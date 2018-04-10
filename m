Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/nOKkxRaxFu+JM7D1Pc4uzl++HGlYftgd4xiyQDgIuwUfOEJ7sG2bGPxVVK1dE3R1djzsa
ARC-Seal: i=1; a=rsa-sha256; t=1523399324; cv=none;
        d=google.com; s=arc-20160816;
        b=drKsWcGdILlt+Qh1fu53FvtR+rTFwYbpj4RDUe4wQ47pVo9Gnrcn65V9UqOqnxM3OB
         CUgIUEXZAsi5E56Ah3XAs64S4/fVKDmbC0sg9w0DKFLxx45Stu6xDZ6pKNBbuAbdWJ2r
         cgvXqPNG3KVh5haJuG9dpAtfzumW7Xkedv6cHFVk7Guqo0uUWOJM/GR3sYV3hE8Q48JI
         7AyPdx7St5+dxHrd6SFyOEWdYr+qKi2e0xH2Yo0TM1sKpP5rHYCrVCIq6wzsVBMoXwOp
         fLlELR+bp/1ztgi6n0J7MMN/uwO7VpQ3A6fB0Q4JUYuatHXxunsF3CJ71EZCg5NECdfW
         juiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pL3jl7onsRS2+YMlRz0vz4MXcXLfazrpZxczy70MlZI=;
        b=jlAXgxKxg6B4sVdZAZNHrnwc/2jTPuem66ZpD6qJdneJ4NQYGCCCXPiBr3vMQlpI5M
         cB4+JrLfpZVBcYjf3IbcG59TY+JNsVrDrtZHgaRHg1HRUPurJIoH94vIoweFKi+6qpJm
         WoBLQXpRlM8jFJEc0N0JV+hZ66ZeEeVs6Gh/o/sGJVy0i1QnYHDarZJy0ZySqzY11jDN
         Bo/ZvBBFKumZ6hRjBMOpR1snaY0YlveY3NieLHDSZogxYad2U3Rd8G3ZG/szTl49KCCM
         mKdG/C0kK68Dtfq4J8HMCHBY8Z9SK62kjeQHtfo+bAjSUe/TNM/osvNX92Qo7a2aueHN
         rloA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 066/168] wl1251: check return from call to wl1251_acx_arp_ip_filter
Date: Wed, 11 Apr 2018 00:23:28 +0200
Message-Id: <20180410212803.006342973@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399970061957195?=
X-GMAIL-MSGID: =?utf-8?q?1597399970061957195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit ac1181c60822292176ab96912208ec9f9819faf8 ]

Currently the less than zero error check on ret is incorrect
as it is checking a far earlier ret assignment rather than the
return from the call to wl1251_acx_arp_ip_filter. Fix this by
adding in the missing assginment.

Detected by CoverityScan, CID#1164835 ("Logically dead code")

Fixes: 204cc5c44fb6 ("wl1251: implement hardware ARP filtering")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ti/wl1251/main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -1200,8 +1200,7 @@ static void wl1251_op_bss_info_changed(s
 		WARN_ON(wl->bss_type != BSS_TYPE_STA_BSS);
 
 		enable = bss_conf->arp_addr_cnt == 1 && bss_conf->assoc;
-		wl1251_acx_arp_ip_filter(wl, enable, addr);
-
+		ret = wl1251_acx_arp_ip_filter(wl, enable, addr);
 		if (ret < 0)
 			goto out_sleep;
 	}
