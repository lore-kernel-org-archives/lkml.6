Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AC7C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B492085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfAUMhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:37:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:25806 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbfAUMhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:37:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 04:37:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="127658307"
Received: from vkunnari-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.163])
  by orsmga002.jf.intel.com with ESMTP; 21 Jan 2019 04:37:40 -0800
Date:   Mon, 21 Jan 2019 14:37:39 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        Matthew Garrett <matthewgarrett@google.com>
Subject: Re: [PATCH v7 5/5] tpm: pass an array of tpm_extend_digest
 structures to tpm_pcr_extend()
Message-ID: <20190121123739.GD9423@linux.intel.com>
References: <20181213102945.30946-1-roberto.sassu@huawei.com>
 <20181213102945.30946-6-roberto.sassu@huawei.com>
 <20181220152122.GB10652@linux.intel.com>
 <c6a3f3e4-bd9d-d060-9ee1-f84310857ba0@huawei.com>
 <20190118151253.GH4080@linux.intel.com>
 <de1cd369-c06c-0107-80cc-fe3967799849@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de1cd369-c06c-0107-80cc-fe3967799849@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:58:22AM +0100, Roberto Sassu wrote:
> Agreed, there should be a clear division.
> 
> 1) The caller shouldn't need to know anything about the chip->info.
> 2) The TPM driver should not rely on the caller to supply all the
> hashes, but verify that all allocated banks are being extended.

1. It is just plain wrong if the basic extend function
   invents its own dummy hashes when it doesn't get one. In the end,
   this is what matters to me, and I'm not going to accept anything that
   tries to do that. That is something that caller should prepare.

   You even left undocumented this very awkward and unguessable
   behaviour. I think redundancy is better than doing guesswork what
   a function might possibly do other than its basic task, which is
   constructing the extend command.
2. The driver should return -EINVAL, if it doesn't get all the hashes.
3. The would be nothing wrong exposing struct tpm_chip in
   include/linux/tpm.h. I would be totally fine with that.

/Jarkko
