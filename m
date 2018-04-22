Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbeDVUan (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 16:30:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:45531 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753495AbeDVUam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 16:30:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,314,1520924400";
   d="scan'208";a="218518931"
Date: Mon, 23 Apr 2018 04:30:00 +0800
From: kbuild test robot <lkp@intel.com>
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: kbuild-all@01.org, tiwai@suse.com, gregkh@linuxfoundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: Re: [alsa-devel] [PATCH 3/4] ALSA: usb-audio: Use Class Specific EP
 for UAC3 devices.
Message-ID: <201804230447.jd3wJQ96%fengguang.wu@intel.com>
References: <20180420170327.31569-4-jorge.sanjuan@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420170327.31569-4-jorge.sanjuan@codethink.co.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sound/for-next]
[also build test WARNING on v4.17-rc1 next-20180420]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jorge-Sanjuan/ALSA-usb-UAC3-new-features/20180423-015726
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/usb/stream.c:597:26: sparse: restricted __le32 degrades to integer

vim +597 sound/usb/stream.c

   544	
   545	static int parse_uac_endpoint_attributes(struct snd_usb_audio *chip,
   546						 struct usb_host_interface *alts,
   547						 int protocol, int iface_no)
   548	{
   549		/* parsed with a v1 header here. that's ok as we only look at the
   550		 * header first which is the same for both versions */
   551		struct uac_iso_endpoint_descriptor *csep;
   552		struct usb_interface_descriptor *altsd = get_iface_desc(alts);
   553		int attributes = 0;
   554	
   555		csep = snd_usb_find_desc(alts->endpoint[0].extra, alts->endpoint[0].extralen, NULL, USB_DT_CS_ENDPOINT);
   556	
   557		/* Creamware Noah has this descriptor after the 2nd endpoint */
   558		if (!csep && altsd->bNumEndpoints >= 2)
   559			csep = snd_usb_find_desc(alts->endpoint[1].extra, alts->endpoint[1].extralen, NULL, USB_DT_CS_ENDPOINT);
   560	
   561		/*
   562		 * If we can't locate the USB_DT_CS_ENDPOINT descriptor in the extra
   563		 * bytes after the first endpoint, go search the entire interface.
   564		 * Some devices have it directly *before* the standard endpoint.
   565		 */
   566		if (!csep)
   567			csep = snd_usb_find_desc(alts->extra, alts->extralen, NULL, USB_DT_CS_ENDPOINT);
   568	
   569		if (!csep || csep->bLength < 7 ||
   570		    csep->bDescriptorSubtype != UAC_EP_GENERAL) {
   571			usb_audio_warn(chip,
   572				       "%u:%d : no or invalid class specific endpoint descriptor\n",
   573				       iface_no, altsd->bAlternateSetting);
   574			return 0;
   575		}
   576	
   577		switch (protocol) {
   578		case UAC_VERSION_1:
   579			attributes = csep->bmAttributes;
   580			break;
   581		case UAC_VERSION_2: {
   582			struct uac2_iso_endpoint_descriptor *csep2 =
   583				(struct uac2_iso_endpoint_descriptor *) csep;
   584	
   585			attributes = csep->bmAttributes & UAC_EP_CS_ATTR_FILL_MAX;
   586	
   587			/* emulate the endpoint attributes of a v1 device */
   588			if (csep2->bmControls & UAC2_CONTROL_PITCH)
   589				attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
   590			break;
   591		}
   592		case UAC_VERSION_3: {
   593			struct uac3_iso_endpoint_descriptor *csep3 =
   594				(struct uac3_iso_endpoint_descriptor *) csep;
   595	
   596			/* emulate the endpoint attributes of a v1 device */
 > 597			if (csep3->bmControls & UAC2_CONTROL_PITCH)
   598				attributes |= UAC_EP_CS_ATTR_PITCH_CONTROL;
   599			break;
   600		}
   601		}
   602	
   603		return attributes;
   604	}
   605	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
