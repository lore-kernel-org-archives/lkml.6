Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0721FECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E182150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mpkO3PZn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E182150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeJQU4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:56:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeJQU4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fs1D7wYZueiWIUgIpfYlZttAIkEuB2iER5LXd+yz1Oo=; b=mpkO3PZnNW3F6/YGdANZctrbm
        e78Dc6tMu3ksZIpZSdhKBlo0Df3bYxb9P6aFzj/nG83Y/Wr+Y11ati/OeaG+lo8GFPxhjOAJ8bYSf
        OorazqRxy8yln/eLiITveEzbDxZcTn7ZXNE2evpKve5KZAFSJ25N6VtBc/vQoY/QrwsUbuPKULVhX
        DgNB8sxkuRzQwyktNX58KCfASLyK1I3gAgYXVOCO2D8hnOcroCmczcuB8XzPOJbHDs+a+t7VuVDLR
        k60mgwu4n+4aASeY7NBhLGdhI/C0pwIdeVh24gAUvsrW4Yyc9FzU6ASQUztHrEAzma3vHtPaPsD94
        9S9/Yhu/A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gClR1-0004WH-RH; Wed, 17 Oct 2018 13:00:23 +0000
Date:   Wed, 17 Oct 2018 06:00:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     YueHaibing <yuehaibing@huawei.com>, hare@suse.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH -next] advansys: remove set but not used variable
 'srb_tag' in adv_isr_callback
Message-ID: <20181017130022.GA3575@bombadil.infradead.org>
References: <20181017123432.18304-1-yuehaibing@huawei.com>
 <4950b4fe-61b5-e1c3-9d16-7643107857a5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4950b4fe-61b5-e1c3-9d16-7643107857a5@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 02:49:50PM +0200, Johannes Thumshirn wrote:
> On 17/10/18 14:34, YueHaibing wrote:
> > -	srb_tag = le32_to_cpu(scsiqp->srb_tag);
> >  	scp = scsi_host_find_tag(boardp->shost, scsiqp->srb_tag);
> 
> Shouldn't this be:
> 	scp = scsi_host_find_tag(boardp->shost,
> 					le32_to_cpu(scsiqp->srb_tag));

I don't think so.  Look at how scsiqp->srb_tag is set:

 adv_build_req(struct asc_board *boardp, struct scsi_cmnd *scp,
              ADV_SCSI_REQ_Q **adv_scsiqpp)
 {
+       u32 srb_tag = scp->request->tag;
...
+       scsiqp->srb_tag = srb_tag;

If we're not converting it to le32 on the way in, we probably don't want
to convert it back on the way out.

Please don't make me power up my PA-RISC machine with an Advansys card
in it, just to find out ...
