Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/T0i+PSNQonFExpK5D5MNokJy/FPcu+BLjvIY4qDkZpfCqSWhGqeU4yJ0YxVu6IoZtPjFY
ARC-Seal: i=1; a=rsa-sha256; t=1523399424; cv=none;
        d=google.com; s=arc-20160816;
        b=ugX7Gfn20vNY169X6fQSm1/7XOdDd3YHmK+JxRju8L5km/2E7XYkX7wKFzIu721HYE
         2eQBScf7sgBtraNOrtvqNt+Yd2Q43fwU93FDtE/73HgqGFYQX/blt4IClESmJEItnw1c
         ru0+N7QM6dDE8AbVod6LofnxxBvb7aQu0KgckCLvWEK2N+K7N5drLexlVZIfdW4Vid8O
         W4ISrpS32uOZNNv06JLGxki/1LVZ2vH3TWZR7v4bdPePLUbTUMjuW68g2lNKMPiS6Zpx
         JRFTG/SGX4GGiAyvkhdPwTIeNdCt1e+s6AXZ67ZBAjf491sKepL0aMBIzpXUhrBA7jzD
         t6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YBpCUqs48yebc02wcvEPKUmTEFVrW6ofpw77q1xBiZc=;
        b=L6rKg97bPA05qOCoxFOE6ijN9xon1dXf9tGjGFi0Qu/U67odDiXsaABdn6n4sHiktf
         5LR7+IMNQzs2ycaOT3axKC0bRYJ2bx7u9PN1PYUAz8uZ9Fh8tLZSUtmxrEEnqDUKFco3
         4qmyz+mrFK3SfGM7ywc7GCHHvr8C60LqP//vdKoRPKmbnqdeoRp6FtKovjc7izHiJeCq
         zN/ev3GGxwWrkiGxezScuNT+4hLP7jAizZP9lzUHEHQjBRbJr4GsOBzxRL2vLpdPkzLH
         NQZQiap1SiRQi9R70wcb/bj/7cGTbdN4VjC7tAklJqKmPlhokIWZiXLyqEXebgLjJFzd
         2itA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 094/168] scsi: megaraid_sas: Error handling for invalid ldcount provided by firmware in RAID map
Date: Wed, 11 Apr 2018 00:23:56 +0200
Message-Id: <20180410212804.249800752@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400074797676914?=
X-GMAIL-MSGID: =?utf-8?q?1597400074797676914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>


[ Upstream commit 7ada701d0d5e5c6d357e157a72b841db3e8d03f4 ]

Currently driver does not validate ldcount provided by firmware.  If the
value is invalid, fail RAID map validation accordingly.  This issue is
rare to hit in field and is fixed as part of code review.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/megaraid/megaraid_sas_fp.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/scsi/megaraid/megaraid_sas_fp.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
@@ -168,7 +168,7 @@ static struct MR_LD_SPAN *MR_LdSpanPtrGe
 /*
  * This function will Populate Driver Map using firmware raid map
  */
-void MR_PopulateDrvRaidMap(struct megasas_instance *instance)
+static int MR_PopulateDrvRaidMap(struct megasas_instance *instance)
 {
 	struct fusion_context *fusion = instance->ctrl_context;
 	struct MR_FW_RAID_MAP_ALL     *fw_map_old    = NULL;
@@ -259,7 +259,7 @@ void MR_PopulateDrvRaidMap(struct megasa
 		ld_count = (u16)le16_to_cpu(fw_map_ext->ldCount);
 		if (ld_count > MAX_LOGICAL_DRIVES_EXT) {
 			dev_dbg(&instance->pdev->dev, "megaraid_sas: LD count exposed in RAID map in not valid\n");
-			return;
+			return 1;
 		}
 
 		pDrvRaidMap->ldCount = (__le16)cpu_to_le16(ld_count);
@@ -285,6 +285,12 @@ void MR_PopulateDrvRaidMap(struct megasa
 			fusion->ld_map[(instance->map_id & 1)];
 		pFwRaidMap = &fw_map_old->raidMap;
 		ld_count = (u16)le32_to_cpu(pFwRaidMap->ldCount);
+		if (ld_count > MAX_LOGICAL_DRIVES) {
+			dev_dbg(&instance->pdev->dev,
+				"LD count exposed in RAID map in not valid\n");
+			return 1;
+		}
+
 		pDrvRaidMap->totalSize = pFwRaidMap->totalSize;
 		pDrvRaidMap->ldCount = (__le16)cpu_to_le16(ld_count);
 		pDrvRaidMap->fpPdIoTimeoutSec = pFwRaidMap->fpPdIoTimeoutSec;
@@ -300,6 +306,8 @@ void MR_PopulateDrvRaidMap(struct megasa
 			sizeof(struct MR_DEV_HANDLE_INFO) *
 			MAX_RAIDMAP_PHYSICAL_DEVICES);
 	}
+
+	return 0;
 }
 
 /*
@@ -317,8 +325,8 @@ u8 MR_ValidateMapInfo(struct megasas_ins
 	u16 ld;
 	u32 expected_size;
 
-
-	MR_PopulateDrvRaidMap(instance);
+	if (MR_PopulateDrvRaidMap(instance))
+		return 0;
 
 	fusion = instance->ctrl_context;
 	drv_map = fusion->ld_drv_map[(instance->map_id & 1)];
