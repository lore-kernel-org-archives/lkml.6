Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id d5McMCZxGlvzNwAAmS7hNA
	; Fri, 08 Jun 2018 12:07:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 480A76089E; Fri,  8 Jun 2018 12:07:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5BC0E605A5;
	Fri,  8 Jun 2018 12:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BC0E605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeFHMG4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:06:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:33556 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbeFHMGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:06:55 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w58C5j4N020111;
        Fri, 8 Jun 2018 07:05:47 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w58C5Yii020108;
        Fri, 8 Jun 2018 07:05:34 -0500
Date: Fri, 8 Jun 2018 07:05:32 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        wei.guo.simon@gmail.com, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 3/4] powerpc/lib: implement strlen() in assembly
Message-ID: <20180608120532.GD17342@gate.crashing.org>
References: <a348f4ffda6349467e4270e754d12150fa773462.1528452373.git.christophe.leroy@c-s.fr> <8d65b5876f55efbd2243f6b43c758e452bee3b54.1528452373.git.christophe.leroy@c-s.fr> <20180608114513.gtgg7o4ejcqrjiz4@lt-gp.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608114513.gtgg7o4ejcqrjiz4@lt-gp.iram.es>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 01:45:13PM +0200, Gabriel Paubert wrote:
> On Fri, Jun 08, 2018 at 10:20:41AM +0000, Christophe Leroy wrote:
> > +	rlwinm.	r8, r9, 0, 0xff000000
> > +	beq	20f
> > +	rlwinm.	r8, r9, 0, 0x00ff0000
> > +	beq	21f
> > +	rlwinm.	r8, r9, 0, 0x0000ff00
> > +	beq	22f
> > +23:	subf	r3, r3, r10
> 
> Actually these rlwinm. can likely be replaced by a single
> cntlzw /cntlzd; for 32 bit something like:
> 
> 	cntlzw  r8,r9
> 	subf    r3,r3,r10	
> 	srwi	r8,r8,3
> 	add	r3,r3,r8
> 	blr

The code is finding the first zero byte in the word, not how many leading
zero bytes there are.


Segher
