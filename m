Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeEEUDS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 16:03:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751183AbeEEUDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 16:03:16 -0400
Date: Sat, 5 May 2018 13:03:15 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: linux-integrity@vger.kernel.org, Laurent Bigonville <bigon@debian.org>
Cc: linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm_tis: verify locality released before returning from
 release_locality
Message-ID: <20180505200315.x7jt33j7psizmfyi@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: linux-integrity@vger.kernel.org,
        Laurent Bigonville <bigon@debian.org>, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20180505195453.10431-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180505195453.10431-1-jsnitsel@redhat.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat May 05 18, Jerry Snitselaar wrote:
>For certain tpm chips releasing locality can take long enough that a
>subsequent call to request_locality will see the locality as being
>active when the access register is read in check_locality. So check
>that the locality has been released before returning from
>release_locality.
>
>Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>Cc: Peter Huewe <peterhuewe@gmx.de>
>Cc: Jason Gunthorpe <jgg@ziepe.ca>
>Reported-by: Laurent Bigonville <bigon@debian.org>
>Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>---
> drivers/char/tpm/tpm_tis_core.c | 47 ++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 46 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>index 5a1f47b43947..d547cd309dbd 100644
>--- a/drivers/char/tpm/tpm_tis_core.c
>+++ b/drivers/char/tpm/tpm_tis_core.c
>@@ -143,13 +143,58 @@ static bool check_locality(struct tpm_chip *chip, int l)
> 	return false;
> }
>
>+static bool locality_inactive(struct tpm_chip *chip, int l)
>+{
>+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>+	int rc;
>+	u8 access;
>+
>+	rc = tpm_tis_read8(priv, TPM_ACCESS(l), &access);
>+	if (rc < 0)
>+		return false;
>+
>+	if ((access & (TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY))
>+	    == TPM_ACCESS_VALID)
>+		return true;
>+
>+	return false;
>+}
>+
> static int release_locality(struct tpm_chip *chip, int l)
> {
> 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>+	unsigned long stop, timeout;
>+	long rc;
>
> 	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
>
>-	return 0;
>+	stop = jiffies + chip->timeout_a;
>+
>+	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
>+again:
>+		timeout = stop - jiffies;
>+		if ((long)timeout <= 0)
>+			return -1;
>+
>+		rc = wait_event_interruptible_timeout(priv->int_queue,
>+						      (locality_inactive(chip, l)),
>+						      timeout);
>+
>+		if (rc > 0)
>+			return 0;
>+
>+		if (rc == -ERESTARTSYS && freezing(current)) {
>+			clear_thread_flag(TIF_SIGPENDING);
>+			goto again;
>+		}
>+	} else {
>+		do {
>+			if (locality_inactive(chip, l))
>+				return 0;
>+			tpm_msleep(TPM_TIMEOUT);
>+		} while (time_before(jiffies, stop));
>+	}
>+	return -1;
> }
>
> static int request_locality(struct tpm_chip *chip, int l)
>-- 
>2.15.0
>

Laurent,

Can you try this patch with your system since it is the one
that has exhibited the problem so far. I've tested on a
tpm2.0 and tpm1.2 system here.

Regards,
Jerry
