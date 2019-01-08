Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19828C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B2C2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546931440;
	bh=r6ycuh6STz8BGinDk1iDj8XCioWJrt++tjWDr8jk0D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HSc1cV0dyF8dfl58IgZsK4jL+qQReGxwDlEoCrx7GF6xIULCYJuzz7b98EZDI8K+M
	 QEJODSHGSmm0NmezQvi0jiWkDyTTj1MP0IkxYCuOBL9W5JWsfXzUgqTn4mpXHaPhfR
	 MqMEQMCQpNaDm1IBidHCAuOjVmGKVj5rIAzQK51w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfAHHKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:10:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfAHHKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:10:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C6D218A1;
        Tue,  8 Jan 2019 07:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546931436;
        bh=r6ycuh6STz8BGinDk1iDj8XCioWJrt++tjWDr8jk0D4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAWLqu+HoMdzqN6ttXdIc0eAjDlN3EC0YDgkeU5a/LUIaq7mP575NXVf79SEpnx0L
         3YRXhRLMNQ4rye8rlPWdJymZ5csYhHZOZHOs19t5d4JyR6JntlwZBieIjnM661OpNM
         ZQigWDefQ2pWGASOnWjZrrk1qRdohSO7S5SySJUI=
Date:   Tue, 8 Jan 2019 08:10:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com,
        borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v4 1/3] virtio-balloon: tweak config_changed
 implementation
Message-ID: <20190108071034.GA32048@kroah.com>
References: <1546923005-40517-1-git-send-email-wei.w.wang@intel.com>
 <1546923005-40517-2-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546923005-40517-2-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 12:50:03PM +0800, Wei Wang wrote:
> virtio-ccw has deadlock issues with reading the config space inside the
> interrupt context, so we tweak the virtballoon_changed implementation
> by moving the config read operations into the related workqueue contexts.
> The config_read_bitmap is used as a flag to the workqueue callbacks
> about the related config fields that need to be read.
> 
> The cmd_id_received is also renamed to cmd_id_received_cache, and
> the value should be obtained via virtio_balloon_cmd_id_received.
> 
> Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/virtio/virtio_balloon.c | 98 +++++++++++++++++++++++++++--------------
>  1 file changed, 65 insertions(+), 33 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
