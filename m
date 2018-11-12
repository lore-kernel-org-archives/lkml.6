Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD18C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FE622360
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C8zkE+/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FE622360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeKLSMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:12:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbeKLSMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D4amv3sWlfC4aQ7tWmCJhpmWlie4JZQvJib98cn2iJA=; b=C8zkE+/UGj2O+eLTI7VKIgNkM
        ydurqFg53dJHbAf+CWI7YMcheIJSqnniPjisf0rod95yyK0tASewmwxOklLKHvfRR/W7FC6M+MP14
        NOegD0cyfWjxVg0YyFQbAuOJlbB+dSfKNRPeRndEyMLBVaDP+KAgTLpjfMa1MLNybzhKFnjqIU6Pi
        NRlxrLSeIAusSKxQLC9MPnJ7q+hD/A3gGSKyls3w2RkotdRoxYxp2sXxasjqevu73VQzQxl240Jnm
        w02m7NKDAyrSr3YAGhP+goNEHYMm973K0R35jcAyzsNIPXKtpslUqborwYZ0umOpqzsrFYOs1M0Oe
        SHvgsccWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gM7S9-0003ir-Tm; Mon, 12 Nov 2018 08:20:13 +0000
Date:   Mon, 12 Nov 2018 00:20:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
Message-ID: <20181112082013.GA9307@infradead.org>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
 <20181111131445.GB25441@infradead.org>
 <20181111134241.GA2447@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111134241.GA2447@thunk.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 08:42:42AM -0500, Theodore Y. Ts'o wrote:
> It really depends on the security model being used on a particular
> system.  I can easily imagine scenarios where userspace is allowed
> full access to the device with respect to read/write/open, but the
> security model doesn't want to allow access to various SCSI commands
> such as firmware upload commands, TCG commads, the
> soon-to-be-standardized Zone Activation Commands (which allow dynamic
> conversion of HDD recording modes between CMR and SMR), etc.

Well, that's what we have the security_file_ioctl() LSM hook for so that
your security model can arbitrate access to ioctls.
