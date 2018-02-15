Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2257whL0XcPb4XIWeiNJYXGmb+voxy7WEZYZ1bm5CvwWdBFOXce93Gp9pWxb6KjkaBTMRR7W
ARC-Seal: i=1; a=rsa-sha256; t=1518709492; cv=none;
        d=google.com; s=arc-20160816;
        b=ZrQId484TZs7gPzJB861J5lKVbLnTeEDpFnEvydAhP2eO48Efzj5vdaGc6NNwY8Cvw
         qzuh7cVIi/eVybDo1tF+BeRHAu0odBsZgJkZdawZRk6LX8d9OffprKySAFTrke/ZYrKD
         14aRjodoV+Vv9v0+ccKh9P/nUaXsVGjyACKZzuWbqYGkZ1HBNg2KmjoTmjKx/io+tR9Z
         DbfTlMx26hBz5+9EA+3l4YbvHRjpJ+/PxxvsR2WR+8KCQYv8Fyjug2SWdrSDB1C/gGMU
         24j5lPn6oBZk2wOxCrbD4h+bGtS847r+1io0dWfiIJfqz2GG+SngBpM/L5p3t5ElNry0
         Qndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oPr+3ppFEtYpZkDUtlewgcJVJn22lD4zNiQ/rp4+Msw=;
        b=u+cAAcfCnwAZymmnVe19nEPkjGMKw7TRQjI3yJcr/UOTL85BVDuu7pb5v74f7+FyMx
         vYMey5XpRrw2LYlXnGJ0WjU8SGfDwshJzmWwL3phNnaCAafeLUOXeMIlRpQCEqjy0Jwz
         al5pr5Ja6rSgWCouCroMblb+wCc4s/oxQLVdRUWazue5oq9Zjs2XyGKogTTQ435Kkgb7
         ESmdCp+XbTAu4A90C1v+L0Y1LpbbhWC0u0RnmyS1dH7KpiSbIuLUuqiD+QapjVsdbbtR
         2isQVJMxfwsJglOCYNaw3TBQV0riunUTCP9TIY2fMcUP4XsX0kW83ibFqrrA3YsLHIDs
         JcOg==
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
Subject: [PATCH 4.15 137/202] ASoC: acpi: fix machine driver selection based on quirk
Date: Thu, 15 Feb 2018 16:17:17 +0100
Message-Id: <20180215151720.284959015@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592482325242185815?=
X-GMAIL-MSGID: =?utf-8?q?1592482325242185815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-acpi.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -84,11 +84,9 @@ snd_soc_acpi_find_machine(struct snd_soc
 
 	for (mach = machines; mach->id[0]; mach++) {
 		if (snd_soc_acpi_check_hid(mach->id) == true) {
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
