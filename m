Return-Path: <arushisinghal19971997@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520196578; cv=none;
        d=google.com; s=arc-20160816;
        b=iXgNisv0aDUuQXnjU27L8OyWcS7cj45tH8cyVWtDPCl8o2KXjCvdNm0TRd39GIQ3pB
         wnV03W+A3Ethzfdyz64iv3lX7BRZAGK58h83Jb4p1d7WYHohcPmSam+L+IMsRd2FHsMb
         JWapem+4MZ5FLTLcL5IGs1WTsIYAz6uqgsePhO90PMSu6Lp+DXw+DAnRACfxTKRj9Dlz
         TSS/ZbfBOCEyquO3tV+nz45f61U9r3AIQ23uUYtI/Lp8lwgP4Ic/+t2O4AfSTUb7gURl
         4++vC6EMLDy0s/Cfj6oyeTz6KQwG66diERvC9X+hxj7GtTqEUHC6/laRVpKaqE9mhv3s
         KRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:dkim-signature:arc-authentication-results;
        bh=KRuwOrNwsp0fF1kPgQFC/iTH1Ld5c7Y5SOixsAeC/v8=;
        b=Cn/Qo7pjx3ZvegLjDvHVCW5UJyOZW+nfWJRpPDewmBswnzdDEkwFJI3bqEd1uiqqWP
         JTiCIAU5gl2VQWCGL4XMbfn7Fvjjf/i+koFaRN5TTmu/0ZXuUqNllhbUHrNhEeEDUOM+
         scbExG3zJBQoW3Pw8BDF2qjLXPAPDBGOL+fdQTD5AG2D4VLdfDh9NprpWMZ2ImouSpN1
         P6ZiTji72TYcaEf8rIPxGx+Q7opASp4Jbdtjj4VWrAtSKqwODU1E9QoMbOqajN6fftVr
         14CMokBOiyQ79Din6oNdMn3Yb1MPtx40lpDT2EV8mgrTqwxxmtapl5P2y+lVvu/RQrRl
         32Dw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=n1Ko2H1o;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=n1Ko2H1o;
       spf=pass (google.com: domain of arushisinghal19971997@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arushisinghal19971997@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvsq9dAD0Izbz5NtlAsbZNmpSm/WdJ8IPryZjBaZJ4IpWZRxeMXm3mmk9ORitGq+GOkyRq6Ug==
Date: Mon, 5 Mar 2018 02:19:11 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH v2] staging: Replace printk() with appropriate
 net_*macro_ratelimited()
Message-ID: <20180304204910.GA4840@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594041647864597387?=
X-GMAIL-MSGID: =?utf-8?q?1594041647864597387?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace printk having a log level with the appropriate
net_*macro_ratelimited.
It's better to use actual device name as a prefix in error messages.
Indentation is also changed, to fix the  checkpatch issue.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
changes in v2
*In previous version printk was changed to pr_*macro(), which is used
in kernel instead of calling printk() directly. And for drivers,
dev_*macro() or net_*macro_ratelimited() should be used for calling
printk() directly.

 drivers/staging/ipx/af_ipx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/ipx/af_ipx.c b/drivers/staging/ipx/af_ipx.c
index d21a9d1..9a96962 100644
--- a/drivers/staging/ipx/af_ipx.c
+++ b/drivers/staging/ipx/af_ipx.c
@@ -744,13 +744,13 @@ static void ipxitf_discover_netnum(struct ipx_interface *intrfc,
 			intrfc->if_netnum = cb->ipx_source_net;
 			ipxitf_add_local_route(intrfc);
 		} else {
-			printk(KERN_WARNING "IPX: Network number collision "
-				"%lx\n        %s %s and %s %s\n",
-				(unsigned long) ntohl(cb->ipx_source_net),
-				ipx_device_name(i),
-				ipx_frame_name(i->if_dlink_type),
-				ipx_device_name(intrfc),
-				ipx_frame_name(intrfc->if_dlink_type));
+			net_warn_ratelimited("IPX: Network number collision "
+					     "%lx\n        %s %s and %s %s\n",
+					     (unsigned long) ntohl(cb->ipx_source_net),
+					     ipx_device_name(i),
+					     ipx_frame_name(i->if_dlink_type),
+					     ipx_device_name(intrfc),
+					     ipx_frame_name(intrfc->if_dlink_type));
 			ipxitf_put(i);
 		}
 	}
-- 
2.7.4
