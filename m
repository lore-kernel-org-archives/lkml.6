Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B61C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D182081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D182081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeLEAqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:46:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:24524 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbeLEAqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:46:47 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 16:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,316,1539673200"; 
   d="scan'208";a="299366323"
Received: from jsakkine-mobl1.jf.intel.com (HELO localhost) ([10.24.8.183])
  by fmsmga006.fm.intel.com with ESMTP; 04 Dec 2018 16:46:44 -0800
Date:   Tue, 4 Dec 2018 16:46:43 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v6 6/7] tpm: ensure that the output of PCR read contains
 the correct digest size
Message-ID: <20181205004643.GA26578@linux.intel.com>
References: <20181204082138.24600-1-roberto.sassu@huawei.com>
 <20181204082138.24600-7-roberto.sassu@huawei.com>
 <20181205000910.GE1233@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205000910.GE1233@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 04:09:10PM -0800, Jarkko Sakkinen wrote:
> On Tue, Dec 04, 2018 at 09:21:37AM +0100, Roberto Sassu wrote:
> >  	out = (struct tpm2_pcr_read_out *)&buf.data[TPM_HEADER_SIZE];
> >  	digest_size = be16_to_cpu(out->digest_size);
> > -	if (digest_size > sizeof(digest->digest)) {
> > +	if (digest_size > sizeof(digest->digest) ||
> > +	    (!digest_size_ptr && digest_size != expected_digest_size)) {
> >  		rc = -EINVAL;
> >  		goto out;
> >  	}
> 
> Just noticed this but you must squash 4-6 because applying only
> previous commits will result a broken tree. It will be much bigger
> commit but won't be broken.
> 
> I think you should also feed min_rsp_body_length as you should be
> able to precalculate.
> 
> Last time I was asking why this isn't a bug fix. It is even for
> the existing code. The existing code should have a bug fix that
> checks that the received digest size so that it is the expected
> SHA1 size before we can apply this commit.

My bad. This is not the same deal as the code because in the old code we
always copy a constant block. Here we use the variable as parameter for
memcpy() so it is better to check the size. You can ignore the last
paragraph completely. Sorry, had to double check this one.

There is no need to do any type of bug fix for the current tree.

Still 4-6 need to be squashed in order to not put purposely the tree
into broken state.

/Jarko
