Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtWnfnkVSgVgpykq3B9SQHyAOZderiSEFAAuLVpytqkypezXUkb00Qgi+Dbt4TKzIEah/0g
ARC-Seal: i=1; a=rsa-sha256; t=1519411012; cv=none;
        d=google.com; s=arc-20160816;
        b=LiEThHw5ziNFLpfRUONnvIV7RQ/iM0lQyi0yspEbT5RCHUS+7qdY5RXbCcuvYZvVkv
         v6B68YTrN8fR5HzPWHY8IGqAO8a8/l/PWxEW0eiKZRpejfHwTTbDeUFt/tL1JvE4PyIK
         7R3Qs3kiTAOBmgzsPWqwCqE1bDHE6VePW4DCYeKfIbVlRBliFJ0qEVzmDw34vegeokoi
         HAwBTnhB08FrCy379A+vFoLCKGVkQeGyRHf7sdFCQ/lLtF2qKZLp6xNDfOnkbMlsNCu+
         WDol0fCXd+/Ce2l3MrOwfvmX6spA+jPLgt+BFGB64JMMUVLZrOLiMKNs5BPjOiEDnSja
         auWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wmkHlu4FXias3YoyMN2Jc4e2cWH+E3I5mDU6FA3d9X4=;
        b=OEsg9ospP3dGgEL0SKSzoCunpTIH5TXGBmKFAw43VHdq/rBHZafVdPjA8gonpFKMWe
         3ggmtql9sC+WUWdJWXVBIIPxclz0sxX/PleFimQ+j/NAZMxXaYNhIq0s7itVQozIesU6
         sPBLRLy9AT0mAVLwQIvnP3BCu36eP2/XYlDa6hwX3ystnIcsRG4YCjMSt+bwoO/eYZQ3
         9m0GRB4LVcE4DomCiXH8REmkMkyJrsSgQg37yjkGVEHS9+VTRfCjYbPEbs8oH4iLY8bQ
         n4QevPOOBTGzTsOqS/en4chqXMpXoyPUOpaNky2c2o+DFPBXMQVZjAj85CNYW9H/GS2r
         zXHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 091/193] mptfusion: hide unused seq_mpt_print_ioc_summary function
Date: Fri, 23 Feb 2018 19:25:24 +0100
Message-Id: <20180223170340.289648646@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217921461979750?=
X-GMAIL-MSGID: =?utf-8?q?1593217921461979750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 28558f5af50d8335cbbc8bc2726e0747553e29f5 upstream.

The seq_mpt_print_ioc_summary function is used for the
/proc/mpt/iocN/summary implementation and never gets called when
CONFIG_PROC_FS is disabled:

drivers/message/fusion/mptbase.c:6851:13: warning: 'seq_mpt_print_ioc_summary' defined but not used [-Wunused-function]
 static void seq_mpt_print_ioc_summary(MPT_ADAPTER *ioc, struct seq_file *m, int showlan)

This adds an #ifdef to hide the function definition in that case and
avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/message/fusion/mptbase.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -6848,6 +6848,7 @@ mpt_print_ioc_summary(MPT_ADAPTER *ioc,
 	*size = y;
 }
 
+#ifdef CONFIG_PROC_FS
 static void seq_mpt_print_ioc_summary(MPT_ADAPTER *ioc, struct seq_file *m, int showlan)
 {
 	char expVer[32];
@@ -6879,6 +6880,7 @@ static void seq_mpt_print_ioc_summary(MP
 
 	seq_putc(m, '\n');
 }
+#endif
 
 /**
  *	mpt_set_taskmgmt_in_progress_flag - set flags associated with task management
