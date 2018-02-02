Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227H/eN0J7YuiHUnAanfXNOW3/8xROjvOzLIdFMuHje8cZIra2Bnx8BSZOBtya8oC5uW4+AK
ARC-Seal: i=1; a=rsa-sha256; t=1517591442; cv=none;
        d=google.com; s=arc-20160816;
        b=IgpXsUjImoKD694k7xMQy2mjZOj+gEVScX/zzK+YItDsj5nZ3XB02E0nWv+ohAmQDs
         EjSjdTrVzt8orPhNZYl6FILdfbbqbQlnObb2Mre783ad1yUpAHex9jMbgOgMgWjStwDJ
         GTmBSKDS7m40KrVRop2vhGihz5e9o35U10yEr8TVj1yC+NmP4ZdNy8xX5Sl5V3Zmjv9i
         VxRZmDwfGDFTh5VD5zAkIHxrCj78W9tSoDvb6zj9SAC/Jco+yxpS/nwO4cUHhB49NJ7d
         5Yc26WZcsMpQL3hocp7//QeSpIBm2skhI2kuWkilXtcBw/9Mv0sFUNtcH6TMED2E0V/P
         FZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=O62YG1Sao71/DE5n9NvRgbkNn2NE4bB8iQ840O1dfs8=;
        b=0YxJ8Qni125XpA2JdHcfyQAOtXrz+DQ3K3NLUowS+3w/WT4Rc/pMCYci5CDFuFVxAP
         KaTKk5aaGBR+gv4PtDs6sqASA8ZEr6GWETgzYl2f5HUKU6BIouRkYfaPWpvP6NepWcNp
         VQrcX5Hn+jhtv6agQk9ltprjsfcKjHgSXbhnGPMvmfEpojcWigfy1J3b4C58Yw9pTlLy
         92sMoxdLt+/QeMzh70k00wJ/DAtF04AxzojAH+QX4Oqt4vILB+odIlWQY7XFlWabL4TK
         XXLF2wBy9aip2Ypkfiv2aMnFNgrcWMNARZAfvU9j4Frx4mKo3VTzc5IulS/q9si1JUL8
         UA+Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 082/156] i2c: i2c-boardinfo: fix memory leaks on devinfo
Date: Fri,  2 Feb 2018 17:57:43 +0100
Message-Id: <20180202140843.980784802@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309964240889073?=
X-GMAIL-MSGID: =?utf-8?q?1591309964240889073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit 66a7c84d677e8e4a5a2ef4afdb9bd52e1399a866 ]

Currently when an error occurs devinfo is still allocated but is
unused when the error exit paths break out of the for-loop. Fix
this by kfree'ing devinfo to avoid the leak.

Detected by CoverityScan, CID#1416590 ("Resource Leak")

Fixes: 4124c4eba402 ("i2c: allow attaching IRQ resources to i2c_board_info")
Fixes: 0daaf99d8424 ("i2c: copy device properties when using i2c_register_board_info()")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/i2c-boardinfo.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/i2c/i2c-boardinfo.c
+++ b/drivers/i2c/i2c-boardinfo.c
@@ -86,6 +86,7 @@ int i2c_register_board_info(int busnum,
 					property_entries_dup(info->properties);
 			if (IS_ERR(devinfo->board_info.properties)) {
 				status = PTR_ERR(devinfo->board_info.properties);
+				kfree(devinfo);
 				break;
 			}
 		}
@@ -98,6 +99,7 @@ int i2c_register_board_info(int busnum,
 					GFP_KERNEL);
 			if (!devinfo->board_info.resources) {
 				status = -ENOMEM;
+				kfree(devinfo);
 				break;
 			}
 		}
