Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48FYxvS0qAzUBanYrXk0Rtzj8kN4TD/h42mxeMWbQWzHwi8hBRbDHsa+h471DSraNqHj5oE
ARC-Seal: i=1; a=rsa-sha256; t=1523472099; cv=none;
        d=google.com; s=arc-20160816;
        b=z1b4mCunUsKMfNcovYMQqQXkp3Nfwa5kEbDWv6E2vjUS8BPk2K9xIoznEK8gdi9ciR
         2WW/ePCvNRknxrGchMVFUdMGyDXnMq+U2sz47ouUQgSeW/n+/4NwJPaiWOI9h32QHIjO
         beWke3eACMPxjvxY9JXDIiqVs2iui2UrO0OQ2Y/idd/qC+ctK11FoDai9o1S0BQAFGli
         baXGFj4sDJyEEh6ERuK0aSFn7gqz2B1g1e/jx+FBYIN42rMIm96VMG+LVDmsym9+Lyua
         E9cYHDfUmEain6JPoBToHZRASIJtxlm9HdlE764KfrWXi48cqLJx0Rv/HA/gO+j8IlFM
         /wkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=pb/AWjQuDuQUgq5UVD9qMMd+5lMLaiDIhfpU6kn6qJc=;
        b=uY0O9EI0njbhpcV0CozJ8Kn2dIKE+YQNKVYYeEmLlgTPR+WTkPNu9nb0ceC5T7rEUk
         QfEJU8nCGMPgnRMJuUfC+d+UncFyu4S3OVM+BkPesQgBNJuqq73mtZV9BrawizD3oIV0
         QzhtEg+YtQgkep7+vZjjEFdzpWcmY/fdtVEn/jDkI1WOWgXEcK4GwL0JA9luLX86rsO0
         Tw/e+0bHbSXzXU7QPrAwBHILFmgTG/BmwPTCDxspwdOWChDlSYPh5je4KCyMWGvbdWRU
         bNnoXrwXYKT35kBhNwZlvnT7+mmkZ8MqfIUe4v07H92TBTk3L2y8BkqSRFAQskiLuiZs
         3UxA==
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
Subject: [PATCH 3.18 052/121] wl1251: check return from call to wl1251_acx_arp_ip_filter
Date: Wed, 11 Apr 2018 20:35:55 +0200
Message-Id: <20180411183459.474405654@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476280416819335?=
X-GMAIL-MSGID: =?utf-8?q?1597476280416819335?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
