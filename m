Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AB8JxZpz5UCCYSeccGx2ZOPGliHhjguaDpjKTGrBIlvxz0A8FZdEfeRxIr4pHFjI0ob/CBVlysTW
ARC-Seal: i=1; a=rsa-sha256; t=1525094588; cv=none;
        d=google.com; s=arc-20160816;
        b=rq3MfWkRsORfcC+sx3lFeUwI8J+OdzTJqOJmwu22K2hu7e+r4dKqsD2yVlXpH19fBN
         SkoGMlUmhHFNrCAVDPJ4fEFudjNOGvP4hlre4NcD9AdcCcrT3IWaIUkq88MtBS3QfSMi
         cw4wYapOftPMAPGylolhpln0N1OjtNrlKH5iJU0Vb+r4KsSYCdPaAqFNG6gdbnLM9Dli
         qsD3G+FRnSDlpBIRglF4iWsCLa2jJ26etCbrBmLY/Bu5rmKVm/4K8DVoVw7gMLuWsO+J
         tp+Wd3SncNZ+WOiSdnVNjQBcoQBrrfVmjKQKkdY8ME2x2tO9KOZmi6UWPv32L3ufpFic
         Tlyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=MFUGT1mFqr8OhIREzZRqyHkWZbwUThJXWTDdJmmsAzw=;
        b=l5nqultRVnrg5GK97xXlyIhON8+drkzquz6c0FHly1Wz6HUlyMJSPknKsRyO9kOhku
         BrwlEg/ciotA4KU0iW8BaKzwoMvBdJZ8HFqshK/M67fToK7Q3+cKrdTJfjKAaIkgaa5J
         GgpaTD7gONwDTtlouCbvKXR9J4yR+cb6MGZNdr5jX5mBAnQDgzmUaA++gSo1Cx4/TGy7
         NYPY2jhofE/cAgri2tevT5viXeTiuWgqlNtH9wFIq9lJXxlyjVdfWeZMKEzuwCj8oCw6
         jFyFQAamXqOlFgxH6e0YyJnR5ZnIx0B87LqNMy36uX7QmtrgLs35FdvOVy/7BhnUKNLT
         HSYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.65.13 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.65.13 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
X-Authority-Reason: nr=8
Date: Mon, 30 Apr 2018 08:23:06 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] typec: tcpm: Fix incorrect 'and' operator
Message-ID: <20180430132305.GA20092@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.172.56.86
X-Source-L: No
X-Exim-ID: 1fD8ln-002KmA-I5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.172.56.86]:50344
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599177583315006788?=
X-GMAIL-MSGID: =?utf-8?q?1599177583315006788?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently, logical and is being used instead of *bitwise* and.

Fix this by using a proper bitwise and operator.

Addresses-Coverity-ID: 1468455 ("Logical vs. bitwise operator")
Fixes: 64f7c494a3c0 ("typec: tcpm: Add support for sink PPS related messages")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/usb/typec/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 1ee259b..7ee417a 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -1772,7 +1772,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
 	enum pd_ext_msg_type type = pd_header_type_le(msg->header);
 	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
 
-	if (!(msg->ext_msg.header && PD_EXT_HDR_CHUNKED)) {
+	if (!(msg->ext_msg.header & PD_EXT_HDR_CHUNKED)) {
 		tcpm_log(port, "Unchunked extended messages unsupported");
 		return;
 	}
-- 
2.7.4
