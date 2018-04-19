Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AIpwx48qJCgvCQ0exHwyavGX4SFBd5X4GBMM4pPlgVpNTUQVvoXACk2ynlfhwMQCs0EPSXyPN3vx
ARC-Seal: i=1; a=rsa-sha256; t=1524144274; cv=none;
        d=google.com; s=arc-20160816;
        b=gLR9S4Ux6a6iAvYhe3fawFaBx5ymsRSSkqXTkv2j0V3UyTtis5YirTDLdwbOEctJ5Y
         n5r7H4Wle6E7+PrXjm8KZeastFP0SfIJl8CqEUFX6HajG6dD9RsO0jreueKmP2Om1du2
         RomVtxwl0EJvfvVBgaLc4WHuw/RkYtAWrA6VU+raMWelirn80sY4tzOrGDXtX3NpwkTR
         fzfKtMakr9lISOBgdAHExyw3WbirojoTq9z6drP/lAdeok3O116Zn7EzrjezdJzb0Ctj
         Oc12ul4la6sViMd5W0iuQ8CStyW5tr8lhXXMwhQzhZLCqZmnnP7maYNScUVxQSt68cmx
         VNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=wUM7gBFf0eK0yqneXIoPPVEmv47cf+1BawOP4AxJP1U=;
        b=c9u/OJIFMq3DSaqj/Y3LlRW7AvOChjhiMNBzi4BFQVXQgqF3H4PHMztByn5H8DW53I
         oPDYWaESb1SAvyXQK3aFitIIirMoR/QzVi90MXZgP0aaMfkeoS9M1SSPeH5vVSLHjefB
         eTBB32hfbyUxZKiW1/LV7u1HQr5673syL3YIUhsFraH1/HfNZxHt+WU2gfr7dFEpcI2o
         aSXvipmbsQuobIfZMlboVRFXgkB25x4ZbUwit7xMcX4cvA+JYCO22GC+wjmnWYhGOP2t
         vxDi0w0UrfMD3BgPo+mHzVwi4YAqHsWmNvgwWSlo8reoYRZh+ujnB3o78tfpJpsBTwPV
         vxwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.194.16 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.194.16 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
X-Authority-Reason: nr=8
Date: Thu, 19 Apr 2018 08:24:29 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Corey Minyard <cminyard@mvista.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ipmi_ssif: Fix uninitialized variable issue
Message-ID: <20180419132429.GA13997@embeddedor.com>
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
X-Source-IP: 189.175.6.211
X-Source-L: No
X-Exim-ID: 1f99Y9-0018AV-BT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.175.6.211]:39740
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598181106409658883?=
X-GMAIL-MSGID: =?utf-8?q?1598181106409658883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently, function ssif_remove returns _rv_, which is a variable that
is never initialized.

Fix this by removing variable _rv_ and return 0 instead.

Addresses-Coverity-ID: 1467999 ("Uninitialized scalar variable")
Fixes: 6a0d23ed338e ("ipmi: ipmi_unregister_smi() cannot fail, have it
return void")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index ecabfe2..37f9ae2 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1227,7 +1227,6 @@ static int ssif_remove(struct i2c_client *client)
 	struct ssif_info *ssif_info = i2c_get_clientdata(client);
 	struct ipmi_smi *intf;
 	struct ssif_addr_info *addr_info;
-	int rv;
 
 	if (!ssif_info)
 		return 0;
@@ -1247,7 +1246,7 @@ static int ssif_remove(struct i2c_client *client)
 		}
 	}
 
-	return rv;
+	return 0;
 }
 
 static int do_cmd(struct i2c_client *client, int len, unsigned char *msg,
-- 
2.7.4
