Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E347C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEDE21A56
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ga68bNHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEDE21A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbeFUSsa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932719AbeFUSs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:48:27 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D16121A51;
        Thu, 21 Jun 2018 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529606907;
        bh=tY1b2QugFkgoNKXGPxDCUljcc2ZJcJ0Oiiexo1gc8eA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ga68bNHO6ffOSDgYu8i48VYyNBWAEhfFzNXpn6WCt6AvUgZgF2A2b0zuEgexFhGaL
         AkPKZqJR66BgW6a25DzaPSoACDjtkMTAmiHHHPLr738FPAm1G7YDCq5XDBzrPJumEu
         t/8jk3RPGCEWAx0SODH4PYH/MR5f/DZ+To08HS6c=
Date:   Thu, 21 Jun 2018 13:48:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com,
        Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH v5 3/5] PCI/AER: Add sysfs attributes to provide
 breakdown of AERs
Message-ID: <20180621184822.GB14136@bhelgaas-glaptop.roam.corp.google.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180620234147.48438-1-rajatja@google.com>
 <20180620234147.48438-3-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620234147.48438-3-rajatja@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Tyler for AER dmesg decoding]

I really like this idea a lot; thanks for putting it together!

On Wed, Jun 20, 2018 at 04:41:45PM -0700, Rajat Jain wrote:
> Add sysfs attributes to provide breakdown of the AERs seen,
> into different type of correctable or uncorrectable errors:
> 
> dev_breakdown_correctable
> dev_breakdown_uncorrectable

- Can you include a more complete sysfs path here in the commit log,
  as well as a snippet of the contents?  From the doc patch, I think
  it is currently:

    /sys/bus/pci/devices/<dev>/aer_stats/dev_breakdown_correctable
    /sys/bus/pci/devices/<dev>/aer_stats/dev_breakdown_uncorrectable

- I'm not sure it's worth making a new subdirectory.  What if you
  simply added these?

    /sys/bus/pci/devices/<dev>/aer_correctable
    /sys/bus/pci/devices/<dev>/aer_uncorrectable

  or perhaps, since you split the "total" files into
  cor/nonfatal/fatal, these could match?

    /sys/bus/pci/devices/<dev>/aer_correctable
    /sys/bus/pci/devices/<dev>/aer_nonfatal
    /sys/bus/pci/devices/<dev>/aer_fatal

  I think the nonfatal/fatal distinction might be worth exposing
  because some of those are configurable and the kernel handling is
  significantly different.  So I think it would make this more
  approachable if the "remove/re-enumerate" situations that will be
  obvious in dmesg logs were clearly connected with "aer_fatal"
  statistics, as opposed to being connected to some subset of what's
  in "aer_uncorrectable".

- Possibly the totals that you currently have in dev_total_cor_errs
  could even be added to the bottom of these?  Not sure what direction
  would be best, and as you say, there's the potential for confusion
  because the individual items won't add up to the totals.  If they
  were in the same file, maybe that could be addressed in the label.

- Can you include the related doc update in the same patch?  That way
  the doc update is more likely to be backported along with the patch.

- I was going to ask whether these should all be in a single file or
  whether they should be split up so there's a separate file for each
  type or error, each containing a single number.  But
  Documentation/filesystems/sysfs.txt says either is OK and
  /sys/devices/system/node/node0/vmstat is an example of a similar
  situation in an existing file, so I think what you did is perfect.

> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v5: Fix the signature
> v4: use "%llu" in place of "%llx"
> v3: Merge everything in aer.c
> 
>  drivers/pci/pcie/aer.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ce0d675d7bd3..c989bb5bb6f1 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -587,10 +587,38 @@ aer_stats_aggregate_attr(dev_total_cor_errs);
>  aer_stats_aggregate_attr(dev_total_fatal_errs);
>  aer_stats_aggregate_attr(dev_total_nonfatal_errs);
>  
> +#define aer_stats_breakdown_attr(field, stats_array, strings_array)	\
> +	static ssize_t							\
> +	field##_show(struct device *dev, struct device_attribute *attr,	\
> +		     char *buf)						\
> +{									\
> +	unsigned int i;							\
> +	char *str = buf;						\
> +	struct pci_dev *pdev = to_pci_dev(dev);				\
> +	u64 *stats = pdev->aer_stats->stats_array;			\

Nit: add a blank line here.

> +	for (i = 0; i < ARRAY_SIZE(strings_array); i++) {		\
> +		if (strings_array[i])					\
> +			str += sprintf(str, "%s = 0x%llu\n",		\
> +				       strings_array[i], stats[i]);	\
> +		else if (stats[i])					\
> +			str += sprintf(str, #stats_array "bit[%d] = 0x%llu\n",\
> +				       i, stats[i]);			\

- I like the way this uses the same text as used in dmesg
  (aer_correctable_error_string[] and
  aer_uncorrectable_error_string[]).

- I think this incorrectly prints a "0x" prefix for a decimal number
  (probably an artifact of your v4 change).

- Tyler posted a patch [1] to update those dmesg strings so they match
  the way lspci decodes them.  I really liked that update, but we
  never quite finished it.  If we're going to do that, it would be
  nice to do it first, so we don't publish new sysfs files, then
  immediately change the labels used in them.

- IIRC, Tyler's patch had the nice property of changing the strings so
  each error name had no spaces, which would make it a little easier
  to parse this sysfs file: each line would be a single identifier
  followed by a single number (I would probably remove the "=" from
  the middle).

[1] https://lkml.kernel.org/r/1518034285-3543-1-git-send-email-tbaicar@codeaurora.org

> +	}								\
> +	return str-buf;							\
> +}									\
> +static DEVICE_ATTR_RO(field)
> +
> +aer_stats_breakdown_attr(dev_breakdown_correctable, dev_cor_errs,
> +			 aer_correctable_error_string);
> +aer_stats_breakdown_attr(dev_breakdown_uncorrectable, dev_uncor_errs,
> +			 aer_uncorrectable_error_string);
> +
>  static struct attribute *aer_stats_attrs[] __ro_after_init = {
>  	&dev_attr_dev_total_cor_errs.attr,
>  	&dev_attr_dev_total_fatal_errs.attr,
>  	&dev_attr_dev_total_nonfatal_errs.attr,
> +	&dev_attr_dev_breakdown_correctable.attr,
> +	&dev_attr_dev_breakdown_uncorrectable.attr,
>  	NULL
>  };
>  
> -- 
> 2.18.0.rc1.244.gcf134e6275-goog
> 
