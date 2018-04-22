Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+A7cCH0O0zjeXTM0mpyB7UdzA7TbClNxNDlGMEgQFbmfoVd3EQsYx/eo/dAtAysnGGMXzI
ARC-Seal: i=1; a=rsa-sha256; t=1524406050; cv=none;
        d=google.com; s=arc-20160816;
        b=vkCpG/a/fCXzBThfx0KL+Vjrvk2RP0acg81j64Gt4hVPDNzzxJTxtwMjfboF6y1nM4
         B6VUrStmufa9ow6MS0zGTMeYvzPSL73L1D/C+98nglPxP6Nw7EjkaORoF5MMVWRFWnzD
         H0VBVGWy1yRKl9lRMLV0gOcjWWQf0IEMrpjcG8B5tJika3r9+j227ZahPq1X9nYoBHVt
         YSig+c50YsUAT9CVm3+Wc7gsXDk/MIIh4/CI+CjRzM+0cESS4tf/hcFDnCRc4QFZa5XX
         Lo37VJYTNpqd37re/3ao71+DyHeaUE9L8MA7HGuQKWP3eVfw7nKuIBMsBKKCNahqTlHm
         SdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F01zkYkwAZHkPjuPM1c62Cn/yQEkeq95km6OI896wtA=;
        b=ujHXwNR9VZr7L1JUOJq4M5SeqjlBGS1zAzBu7ViKixWn1UYzTS2dz1kk6PJZEE/yCH
         EzvnPR8MeDjLNluWvREEk2iDkXqNF0KfRItAft3pon8sQJpDleoqNmSaGnKfkXqhYDww
         DXzJNEgM66DG9o5/BOL2oLIfEszV1jhvFPbAFLczzFfqI5OmQkE9xMg3RC6Cjn2ep7KI
         byhc6oqDwlLDofOAl0/j+FjSKRlKiil1O9zylHlavuJL+zaqI6y4105DrIxWpWGDFJx8
         iVGg9qmiIOZXBRdBZbDDA2VXYGb9aSOukdtKjexDr4yz4Ew/c342KBuvYGjjtjmZCYaL
         4SUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Chiu <chiu@endlessm.com>,
	Daniel Drake <drake@endlessm.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 4.14 094/164] tpm: self test failure should not cause suspend to fail
Date: Sun, 22 Apr 2018 15:52:41 +0200
Message-Id: <20180422135139.269456088@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455191050669337?=
X-GMAIL-MSGID: =?utf-8?q?1598455598761917389?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Chiu <chiu@endlessm.com>

commit 0803d7befa15cab5717d667a97a66214d2a4c083 upstream.

The Acer Acer Veriton X4110G has a TPM device detected as:
  tpm_tis 00:0b: 1.2 TPM (device-id 0xFE, rev-id 71)

After the first S3 suspend, the following error appears during resume:
  tpm tpm0: A TPM error(38) occurred continue selftest

Any following S3 suspend attempts will now fail with this error:
  tpm tpm0: Error (38) sending savestate before suspend
  PM: Device 00:0b failed to suspend: error 38

Error 38 is TPM_ERR_INVALID_POSTINIT which means the TPM is
not in the correct state. This indicates that the platform BIOS
is not sending the usual TPM_Startup command during S3 resume.
>From this point onwards, all TPM commands will fail.

The same issue was previously reported on Foxconn 6150BK8MC and
Sony Vaio TX3.

The platform behaviour seems broken here, but we should not break
suspend/resume because of this.

When the unexpected TPM state is encountered, set a flag to skip the
affected TPM_SaveState command on later suspends.

Cc: stable@vger.kernel.org
Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Link: http://lkml.kernel.org/r/CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com
Link: https://lkml.org/lkml/2011/3/28/192
Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=591031
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-interface.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -971,6 +971,10 @@ int tpm_do_selftest(struct tpm_chip *chi
 	loops = jiffies_to_msecs(duration) / delay_msec;
 
 	rc = tpm_continue_selftest(chip);
+	if (rc == TPM_ERR_INVALID_POSTINIT) {
+		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
+		dev_info(&chip->dev, "TPM not ready (%d)\n", rc);
+	}
 	/* This may fail if there was no TPM driver during a suspend/resume
 	 * cycle; some may return 10 (BAD_ORDINAL), others 28 (FAILEDSELFTEST)
 	 */
