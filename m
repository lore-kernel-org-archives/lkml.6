Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291B6C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D1520872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D1520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeFTOPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:15:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:60935 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752725AbeFTOPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:15:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 07:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,247,1526367600"; 
   d="scan'208";a="238796964"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga005.fm.intel.com with ESMTP; 20 Jun 2018 07:15:35 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fVdtT-000L2s-Mb; Wed, 20 Jun 2018 22:15:31 +0800
Date:   Wed, 20 Jun 2018 22:14:44 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Cc:     kbuild-all@01.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org,
        Ricardo Schwarzmeier <Ricardo.Schwarzmeier@infineon.com>
Subject: Re: [PATCH v2] tpm: Return the actual size when receiving an
 unsupported command
Message-ID: <201806202248.zEM6vINs%fengguang.wu@intel.com>
References: <20180620095507.682-1-Ricardo.Schwarzmeier@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620095507.682-1-Ricardo.Schwarzmeier@infineon.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on v4.18-rc1 next-20180620]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ricardo-Schwarzmeier/tpm-Return-the-actual-size-when-receiving-an-unsupported-command/20180620-210928
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/char/tpm/tpm-interface.c:426:30: sparse: incorrect type in return expression (different base types) @@    expected long @@    got restricted __be32 [usertylong @@
   drivers/char/tpm/tpm-interface.c:426:30:    expected long
   drivers/char/tpm/tpm-interface.c:426:30:    got restricted __be32 [usertype] length
   drivers/char/tpm/tpm-interface.c:565:34: sparse: expression using sizeof(void)
   drivers/char/tpm/tpm-interface.c:565:34: sparse: expression using sizeof(void)
   drivers/char/tpm/tpm-interface.c:1258:31: sparse: expression using sizeof(void)

vim +426 drivers/char/tpm/tpm-interface.c

   401	
   402	static ssize_t tpm_try_transmit(struct tpm_chip *chip,
   403					struct tpm_space *space,
   404					u8 *buf, size_t bufsiz,
   405					unsigned int flags)
   406	{
   407		struct tpm_output_header *header = (void *)buf;
   408		int rc;
   409		ssize_t len = 0;
   410		u32 count, ordinal;
   411		unsigned long stop;
   412		bool need_locality;
   413	
   414		rc = tpm_validate_command(chip, space, buf, bufsiz);
   415		if (rc == -EINVAL)
   416			return rc;
   417		/*
   418		 * If the command is not implemented by the TPM, synthesize a
   419		 * response with a TPM2_RC_COMMAND_CODE return for user-space.
   420		 */
   421		if (rc == -EOPNOTSUPP) {
   422			header->length = cpu_to_be32(sizeof(*header));
   423			header->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
   424			header->return_code = cpu_to_be32(TPM2_RC_COMMAND_CODE |
   425							  TSS2_RESMGR_TPM_RC_LAYER);
 > 426			return header->length;
   427		}
   428	
   429		if (bufsiz > TPM_BUFSIZE)
   430			bufsiz = TPM_BUFSIZE;
   431	
   432		count = be32_to_cpu(*((__be32 *) (buf + 2)));
   433		ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
   434		if (count == 0)
   435			return -ENODATA;
   436		if (count > bufsiz) {
   437			dev_err(&chip->dev,
   438				"invalid count value %x %zx\n", count, bufsiz);
   439			return -E2BIG;
   440		}
   441	
   442		if (!(flags & TPM_TRANSMIT_UNLOCKED))
   443			mutex_lock(&chip->tpm_mutex);
   444	
   445	
   446		if (chip->ops->clk_enable != NULL)
   447			chip->ops->clk_enable(chip, true);
   448	
   449		/* Store the decision as chip->locality will be changed. */
   450		need_locality = chip->locality == -1;
   451	
   452		if (!(flags & TPM_TRANSMIT_RAW) && need_locality) {
   453			rc = tpm_request_locality(chip);
   454			if (rc < 0)
   455				goto out_no_locality;
   456		}
   457	
   458		if (chip->dev.parent)
   459			pm_runtime_get_sync(chip->dev.parent);
   460	
   461		rc = tpm2_prepare_space(chip, space, ordinal, buf);
   462		if (rc)
   463			goto out;
   464	
   465		rc = chip->ops->send(chip, buf, count);
   466		if (rc < 0) {
   467			if (rc != -EPIPE)
   468				dev_err(&chip->dev,
   469					"%s: tpm_send: error %d\n", __func__, rc);
   470			goto out;
   471		}
   472	
   473		if (chip->flags & TPM_CHIP_FLAG_IRQ)
   474			goto out_recv;
   475	
   476		if (chip->flags & TPM_CHIP_FLAG_TPM2)
   477			stop = jiffies + tpm2_calc_ordinal_duration(chip, ordinal);
   478		else
   479			stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
   480		do {
   481			u8 status = chip->ops->status(chip);
   482			if ((status & chip->ops->req_complete_mask) ==
   483			    chip->ops->req_complete_val)
   484				goto out_recv;
   485	
   486			if (chip->ops->req_canceled(chip, status)) {
   487				dev_err(&chip->dev, "Operation Canceled\n");
   488				rc = -ECANCELED;
   489				goto out;
   490			}
   491	
   492			tpm_msleep(TPM_TIMEOUT_POLL);
   493			rmb();
   494		} while (time_before(jiffies, stop));
   495	
   496		chip->ops->cancel(chip);
   497		dev_err(&chip->dev, "Operation Timed out\n");
   498		rc = -ETIME;
   499		goto out;
   500	
   501	out_recv:
   502		len = chip->ops->recv(chip, buf, bufsiz);
   503		if (len < 0) {
   504			rc = len;
   505			dev_err(&chip->dev,
   506				"tpm_transmit: tpm_recv: error %d\n", rc);
   507			goto out;
   508		} else if (len < TPM_HEADER_SIZE) {
   509			rc = -EFAULT;
   510			goto out;
   511		}
   512	
   513		if (len != be32_to_cpu(header->length)) {
   514			rc = -EFAULT;
   515			goto out;
   516		}
   517	
   518		rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
   519	
   520	out:
   521		if (chip->dev.parent)
   522			pm_runtime_put_sync(chip->dev.parent);
   523	
   524		if (need_locality)
   525			tpm_relinquish_locality(chip);
   526	
   527	out_no_locality:
   528		if (chip->ops->clk_enable != NULL)
   529			chip->ops->clk_enable(chip, false);
   530	
   531		if (!(flags & TPM_TRANSMIT_UNLOCKED))
   532			mutex_unlock(&chip->tpm_mutex);
   533		return rc ? rc : len;
   534	}
   535	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
