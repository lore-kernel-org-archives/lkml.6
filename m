Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2596C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FED920830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FED920830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbeKGJQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:16:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35564 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387726AbeKGJQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:16:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id 32-v6so6531854pgu.2;
        Tue, 06 Nov 2018 15:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hPcRdl+fVZ7K/XmxsWrM9/WvMiO+cdHK6C26sWAH0Yg=;
        b=r0v+zjDkUl3WbVBd9EakFBXzT4sWLky/Y3JmS4axYD16YpIlV1xO0602Yz2ds4rcLX
         Ky+gcdAoOKDJiL3c6xmRNEQmoj20JrBISGbM3r4kXqpY7ZG42VRK0TgoZns8cOLZViNR
         +9gvWjpS/SVAR4E9fNJjG6A/7MLcUSWrZ/S/ycTxcwpAM2RqXZGON3UEP4HyDGhr1q8K
         /G8YQ0rcTiRy/rrDk7r8KMWvMOU13M5Wpfi0Eh4HzO1OB8l8Obl5I01mXjwcrsBj7dDq
         bjkJOE3fJy+6wLyM1vDvPbwNu0cyM8KI4nnflNDmIvssUMu+yhA8GH0eyDAc54ZEB111
         eDPA==
X-Gm-Message-State: AGRZ1gLTdqWkkc03tGUjbDrMGJhbC0r6/6DY/ITpQtIuSkyZbtniIqE2
        oKXYxXkuSz4NT0esJIHsiu8=
X-Google-Smtp-Source: AJdET5fiOvIbGLYrd6uOouTcHn9SiNCrwGM4VnJKiB2pHVsUKANh6DEz6vt/lSCTFMpA7SvMsOWZ5w==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr11328591pgq.189.1541548116412;
        Tue, 06 Nov 2018 15:48:36 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 62sm44385819pgc.61.2018.11.06.15.48.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 15:48:35 -0800 (PST)
Message-ID: <1541548114.196084.195.camel@acm.org>
Subject: Re: [driver-core PATCH v5 5/9] driver core: Establish clear order
 of operations for deferred probe and remove
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com
Date:   Tue, 06 Nov 2018 15:48:34 -0800
In-Reply-To: <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
         <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 13:12 -0800, Alexander Duyck wrote:
+AD4 One change I made in addition is I replaced the use of +ACI-bool X:1+ACI to define
+AD4 the bitfield to a +ACI-u8 X:1+ACI setup in order to resolve some checkpatch
+AD4 warnings.

Please use +ACI-bool X:1+ACI instead of +ACI-u8 X:1+ACI. I think it was a bad idea to make
checkpatch complain about +ACI-bool X:1+ACI since +ACI-bool X:1+ACI should only be avoided
in structures for which alignment must be architecture-independent. For struct
device it is fine if member alignment differs per architecture. Additionally,
changing +ACI-bool X:1+ACI into +ACI-u8 X:1+ACI will reduce performance on architectures that
cannot do byte addressing.

+AD4  static void +AF8AXw-device+AF8-release+AF8-driver(struct device +ACo-dev, struct device +ACo-parent)
+AD4  +AHs
+AD4 -	struct device+AF8-driver +ACo-drv+ADs
+AD4 +-	struct device+AF8-driver +ACo-drv +AD0 dev-+AD4-driver+ADs
+AD4  
+AD4 -	drv +AD0 dev-+AD4-driver+ADs
+AD4 -	if (drv) +AHs
+AD4 -		while (device+AF8-links+AF8-busy(dev)) +AHs
+AD4 -			+AF8AXw-device+AF8-driver+AF8-unlock(dev, parent)+ADs
+AD4 +-	/+ACo
+AD4 +-	 +ACo In the event that we are asked to release the driver on an
+AD4 +-	 +ACo interface that is still waiting on a probe we can just terminate
+AD4 +-	 +ACo the probe by setting async+AF8-probe to false. When the async call
+AD4 +-	 +ACo is finally completed it will see this state and just exit.
+AD4 +-	 +ACo-/
+AD4 +-	dev-+AD4-async+AF8-probe +AD0 false+ADs
+AD4 +-	if (+ACE-drv)
+AD4 +-		return+ADs
+AD4  
+AD4 -			device+AF8-links+AF8-unbind+AF8-consumers(dev)+ADs
+AD4 +-	while (device+AF8-links+AF8-busy(dev)) +AHs
+AD4 +-		+AF8AXw-device+AF8-driver+AF8-unlock(dev, parent)+ADs
+AD4  
+AD4 -			+AF8AXw-device+AF8-driver+AF8-lock(dev, parent)+ADs
+AD4 -			/+ACo
+AD4 -			 +ACo A concurrent invocation of the same function might
+AD4 -			 +ACo have released the driver successfully while this one
+AD4 -			 +ACo was waiting, so check for that.
+AD4 -			 +ACo-/
+AD4 -			if (dev-+AD4-driver +ACEAPQ drv)
+AD4 -				return+ADs
+AD4 -		+AH0
+AD4 +-		device+AF8-links+AF8-unbind+AF8-consumers(dev)+ADs
+AD4  
+AD4 -		pm+AF8-runtime+AF8-get+AF8-sync(dev)+ADs
+AD4 -		pm+AF8-runtime+AF8-clean+AF8-up+AF8-links(dev)+ADs
+AD4 +-		+AF8AXw-device+AF8-driver+AF8-lock(dev, parent)+ADs
+AD4 +-		/+ACo
+AD4 +-		 +ACo A concurrent invocation of the same function might
+AD4 +-		 +ACo have released the driver successfully while this one
+AD4 +-		 +ACo was waiting, so check for that.
+AD4 +-		 +ACo-/
+AD4 +-		if (dev-+AD4-driver +ACEAPQ drv)
+AD4 +-			return+ADs
+AD4 +-	+AH0
+AD4  
+AD4 -		driver+AF8-sysfs+AF8-remove(dev)+ADs
+AD4 +-	pm+AF8-runtime+AF8-get+AF8-sync(dev)+ADs
+AD4 +-	pm+AF8-runtime+AF8-clean+AF8-up+AF8-links(dev)+ADs
+AD4  
+AD4 -		if (dev-+AD4-bus)
+AD4 -			blocking+AF8-notifier+AF8-call+AF8-chain(+ACY-dev-+AD4-bus-+AD4-p-+AD4-bus+AF8-notifier,
+AD4 -						     BUS+AF8-NOTIFY+AF8-UNBIND+AF8-DRIVER,
+AD4 -						     dev)+ADs
+AD4 +-	driver+AF8-sysfs+AF8-remove(dev)+ADs
+AD4  
+AD4 -		pm+AF8-runtime+AF8-put+AF8-sync(dev)+ADs
+AD4 +-	if (dev-+AD4-bus)
+AD4 +-		blocking+AF8-notifier+AF8-call+AF8-chain(+ACY-dev-+AD4-bus-+AD4-p-+AD4-bus+AF8-notifier,
+AD4 +-					     BUS+AF8-NOTIFY+AF8-UNBIND+AF8-DRIVER,
+AD4 +-					     dev)+ADs
+AD4  
+AD4 -		if (dev-+AD4-bus +ACYAJg dev-+AD4-bus-+AD4-remove)
+AD4 -			dev-+AD4-bus-+AD4-remove(dev)+ADs
+AD4 -		else if (drv-+AD4-remove)
+AD4 -			drv-+AD4-remove(dev)+ADs
+AD4 +-	pm+AF8-runtime+AF8-put+AF8-sync(dev)+ADs
+AD4  
+AD4 -		device+AF8-links+AF8-driver+AF8-cleanup(dev)+ADs
+AD4 -		arch+AF8-teardown+AF8-dma+AF8-ops(dev)+ADs
+AD4 +-	if (dev-+AD4-bus +ACYAJg dev-+AD4-bus-+AD4-remove)
+AD4 +-		dev-+AD4-bus-+AD4-remove(dev)+ADs
+AD4 +-	else if (drv-+AD4-remove)
+AD4 +-		drv-+AD4-remove(dev)+ADs
+AD4  
+AD4 -		devres+AF8-release+AF8-all(dev)+ADs
+AD4 -		dev-+AD4-driver +AD0 NULL+ADs
+AD4 -		dev+AF8-set+AF8-drvdata(dev, NULL)+ADs
+AD4 -		if (dev-+AD4-pm+AF8-domain +ACYAJg dev-+AD4-pm+AF8-domain-+AD4-dismiss)
+AD4 -			dev-+AD4-pm+AF8-domain-+AD4-dismiss(dev)+ADs
+AD4 -		pm+AF8-runtime+AF8-reinit(dev)+ADs
+AD4 -		dev+AF8-pm+AF8-set+AF8-driver+AF8-flags(dev, 0)+ADs
+AD4 +-	device+AF8-links+AF8-driver+AF8-cleanup(dev)+ADs
+AD4 +-	arch+AF8-teardown+AF8-dma+AF8-ops(dev)+ADs
+AD4 +-
+AD4 +-	devres+AF8-release+AF8-all(dev)+ADs
+AD4 +-	dev-+AD4-driver +AD0 NULL+ADs
+AD4 +-	dev+AF8-set+AF8-drvdata(dev, NULL)+ADs
+AD4 +-	if (dev-+AD4-pm+AF8-domain +ACYAJg dev-+AD4-pm+AF8-domain-+AD4-dismiss)
+AD4 +-		dev-+AD4-pm+AF8-domain-+AD4-dismiss(dev)+ADs
+AD4 +-	pm+AF8-runtime+AF8-reinit(dev)+ADs
+AD4 +-	dev+AF8-pm+AF8-set+AF8-driver+AF8-flags(dev, 0)+ADs
+AD4  
+AD4 -		klist+AF8-remove(+ACY-dev-+AD4-p-+AD4-knode+AF8-driver)+ADs
+AD4 -		device+AF8-pm+AF8-check+AF8-callbacks(dev)+ADs
+AD4 -		if (dev-+AD4-bus)
+AD4 -			blocking+AF8-notifier+AF8-call+AF8-chain(+ACY-dev-+AD4-bus-+AD4-p-+AD4-bus+AF8-notifier,
+AD4 -						     BUS+AF8-NOTIFY+AF8-UNBOUND+AF8-DRIVER,
+AD4 -						     dev)+ADs
+AD4 +-	klist+AF8-remove(+ACY-dev-+AD4-p-+AD4-knode+AF8-driver)+ADs
+AD4 +-	device+AF8-pm+AF8-check+AF8-callbacks(dev)+ADs
+AD4 +-	if (dev-+AD4-bus)
+AD4 +-		blocking+AF8-notifier+AF8-call+AF8-chain(+ACY-dev-+AD4-bus-+AD4-p-+AD4-bus+AF8-notifier,
+AD4 +-					     BUS+AF8-NOTIFY+AF8-UNBOUND+AF8-DRIVER,
+AD4 +-					     dev)+ADs
+AD4  
+AD4 -		kobject+AF8-uevent(+ACY-dev-+AD4-kobj, KOBJ+AF8-UNBIND)+ADs
+AD4 -	+AH0
+AD4 +-	kobject+AF8-uevent(+ACY-dev-+AD4-kobj, KOBJ+AF8-UNBIND)+ADs
+AD4  +AH0

This patch mixes functional changes with whitespace changes. Please move the
whitespace changes into a separate patch such that this patch becomes easier
to read.
 
+AD4  void device+AF8-release+AF8-driver+AF8-internal(struct device +ACo-dev,
+AD4 diff --git a/include/linux/device.h b/include/linux/device.h
+AD4 index 1b25c7a43f4c..fc7091d436c2 100644
+AD4 --- a/include/linux/device.h
+AD4 +-+-+- b/include/linux/device.h
+AD4 +AEAAQA -1043,14 +-1043,15 +AEAAQA struct device +AHs
+AD4  	struct iommu+AF8-group	+ACo-iommu+AF8-group+ADs
+AD4  	struct iommu+AF8-fwspec	+ACo-iommu+AF8-fwspec+ADs
+AD4  
+AD4 -	bool			offline+AF8-disabled:1+ADs
+AD4 -	bool			offline:1+ADs
+AD4 -	bool			of+AF8-node+AF8-reused:1+ADs
+AD4 +-	u8			offline+AF8-disabled:1+ADs
+AD4 +-	u8			offline:1+ADs
+AD4 +-	u8			of+AF8-node+AF8-reused:1+ADs
+AD4  +ACM-if defined(CONFIG+AF8-ARCH+AF8-HAS+AF8-SYNC+AF8-DMA+AF8-FOR+AF8-DEVICE) +AHwAfA +AFw
+AD4      defined(CONFIG+AF8-ARCH+AF8-HAS+AF8-SYNC+AF8-DMA+AF8-FOR+AF8-CPU) +AHwAfA +AFw
+AD4      defined(CONFIG+AF8-ARCH+AF8-HAS+AF8-SYNC+AF8-DMA+AF8-FOR+AF8-CPU+AF8-ALL)
+AD4 -	bool			dma+AF8-coherent:1+ADs
+AD4 +-	u8			dma+AF8-coherent:1+ADs
+AD4  +ACM-endif
+AD4 +-	u8			async+AF8-probe:1+ADs

The new async+AF8-probe field can be changed from multiple threads. Concurrent
changes of a bitfield are only safe if these are serialized in some way.
Please document the locking requirements for the async+AF8-probe bitfield in
device.h.

Thanks,

Bart.
