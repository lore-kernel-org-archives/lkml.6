Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48MylXVoMMlaaQXcB1ughSiFDlbZrQZ2aPjVxBOleEfGHdfOnZGz+XoWQKqh00bOa1M1BsE
ARC-Seal: i=1; a=rsa-sha256; t=1524405662; cv=none;
        d=google.com; s=arc-20160816;
        b=fqPWPz3csTn6S4u+GElBNhNdxmUuk/JMCLuqY9pH/9dZ7WBpB8w+foBbL3vJqKh+4F
         lmL0s9ZTbpHnfzWrkYSCEff5dGQyZ0rDMTrMZLC+zfRxmCagdcehymbXeuPDwzOQkryn
         Vg3o/9TJOB2jqNsbtodNFH8l6he7ZnYnQi67T0HnWc4bennJLow49smR/E3zgO/1eR+l
         LobY0TsqbZcjQF+VlLoujC6BE3s2/SIDtw1iYSErPyQJ4GzfBDOKy3TnNBVSiVyWz5ZK
         hrdblQb7d4Bpnolm4MjEnXG+hk9L1mQYrWnbK2gTJo3BJFYSuFmDeQnfMnBEixR5KuIJ
         jpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GT2MSDESAXvaY4Ssh65dxXo6FZO+TLkg+jDFnGpK/zY=;
        b=utii1Lt2QvH2Rss+g4E9BNOLkjJgcA51IAKQPM43Lu09/M6S1M2jlPwvSWRkdm9oeo
         SohHDi5N0zAeeTfGGR1Y1IpE8UmknWfcndurtrzV6CSed4JEzEuW4vEYAOJPLhQ/OHvg
         aTXB5Z4ae66NqNkdT6TPq+8wZviFwTvik3ZlEptGQSqPMbxDV4ayqOqR2l+Z95FPbC9/
         qLdPpwPZEp2XBa5DGrWSdKRtxE3X7X75iURdEIlK8mGXfJtVtLpIAtOdZ2FNAZGTdfwh
         zEmIvvbymCpMkyizZ4ZG0IET2jdAj1q4+aMqpj54eJag5dY3EZvDYs1v8Ip2SBs7fM7u
         i/LA==
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
Subject: [PATCH 4.16 121/196] tpm: self test failure should not cause suspend to fail
Date: Sun, 22 Apr 2018 15:52:21 +0200
Message-Id: <20180422135110.509960922@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455191050669337?=
X-GMAIL-MSGID: =?utf-8?q?1598455191050669337?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -969,6 +969,10 @@ int tpm_do_selftest(struct tpm_chip *chi
 	loops = jiffies_to_msecs(duration) / delay_msec;
 
 	rc = tpm_continue_selftest(chip);
+	if (rc == TPM_ERR_INVALID_POSTINIT) {
+		chip->flags |= TPM_CHIP_FLAG_ALWAYS_POWERED;
+		dev_info(&chip->dev, "TPM not ready (%d)\n", rc);
+	}
 	/* This may fail if there was no TPM driver during a suspend/resume
 	 * cycle; some may return 10 (BAD_ORDINAL), others 28 (FAILEDSELFTEST)
 	 */
