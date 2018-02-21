Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2267VpqOkfwABpmu+U6mUfkaafky/MRCE7VSSCfabmca0Yvk5VlKHI0QJk1uqD+Nr6kpGPIw
ARC-Seal: i=1; a=rsa-sha256; t=1519218324; cv=none;
        d=google.com; s=arc-20160816;
        b=IgGsf5NXfmaS2m+s/6sJ+/0XXNoRwpwUGIjdsOLtGdywWFGS3eRG9Wpw+dh2k19iXH
         e5yArfGwUB5MJUuhwYENAUS8+ttSytyJpFAEJ/lZhvGMDeFrwu04Q2UmTQgMbp9evytL
         /D24NthV94XzfKUt3H4ZaDgrbumCo9lrh60k8oY0OsnKI9EXiwwh96B+HCnmfjOTfOFf
         29HpG48+/p5ZbmqZxtIS6gSiSXhxp2TDOy8Mhij3jwHtJCi7jhhNn4hXtvJL+ZU/kYTk
         /Bm8aSti0F7Z/pYa7M/IdSmQ/xOk17hERC+3yYN3ZZKmW6lL0T+X3zHFTpgoSscEPkcQ
         DJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JmxFSFJCQ5Gjj7zAkPcVgJURqzSvGRtdaFZ0tGrYqbI=;
        b=FYxQd+1SgI6GOmoNZ1OzV31oQeSUjjTuxQbcRHBgf3xEVv6vgZAIwcbZ3DWzZ7wCVX
         6iWBp2cbJDjzaqbC5n1/XZwX2JXN6D2DkQT0Ms1ym5x41UNxrZKOhK4sSHuPWCqemBZG
         SXMF9FTiKmfu8nm1ud8wdtdgBkQ11ImsHTrpjyHWoUZjyd7lMsIaju/PYoQQ8aY4+zTa
         RzVIlgSGTqYkIf0FziuQ64zLU2LYG46wPsl9uEiPsVgbfMzevekRnBq01uEf/dZ9M7dA
         hSPPscwqqHmWQs2/n+09Qoz8C9Cu1QaPncXWn7Uj73bGwiPK5qYplaYymaguj28gIMtA
         1Ogg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Nicole=20F=C3=A6rber?= <nicole.faerber@dpin.de>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 166/167] ASoC: acpi: fix machine driver selection based on quirk
Date: Wed, 21 Feb 2018 13:49:37 +0100
Message-Id: <20180221124533.934366054@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015874113216867?=
X-GMAIL-MSGID: =?utf-8?q?1593015874113216867?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

commit 5c256045b87b8aa8e5bc9d2e2fdc0802351c1f99 upstream.

The ACPI/machine-driver code refactoring introduced in 4.13 introduced
a regression for cases where we need a DMI-based quirk to select the
machine driver (the BIOS reports an invalid HID). The fix is just to
make sure the results of the quirk are actually used.

Fixes: 54746dabf770 ('ASoC: Improve machine driver selection based on quirk data')
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=96691
Tested-by: Nicole Færber <nicole.faerber@dpin.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/common/sst-match-acpi.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/sound/soc/intel/common/sst-match-acpi.c
+++ b/sound/soc/intel/common/sst-match-acpi.c
@@ -83,11 +83,9 @@ struct sst_acpi_mach *sst_acpi_find_mach
 
 	for (mach = machines; mach->id[0]; mach++) {
 		if (sst_acpi_check_hid(mach->id) == true) {
-			if (mach->machine_quirk == NULL)
-				return mach;
-
-			if (mach->machine_quirk(mach) != NULL)
-				return mach;
+			if (mach->machine_quirk)
+				mach = mach->machine_quirk(mach);
+			return mach;
 		}
 	}
 	return NULL;
