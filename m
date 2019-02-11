Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311E6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000DE218AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E+H12NWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfBKSG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:06:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46722 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfBKSG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:06:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so5277259pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w0y9hW+FfwZmqRbEGDUn/tatRO/LwdPvsfhlv3Glf8s=;
        b=E+H12NWqOH1kocgLBJFfdyfUTGtO82CGQL/Q5abd40O4IhGdaqRBFiSCmc8bOl2JEq
         wxji4EQNCE0kjaQDY58Pr8AW0elv7SDRpJjmnPhtSKWmRdld9oOKPYdMp8cbXgtihTkN
         YpvY7172JPcd5+1Lr9i4nZ3vf7k3qSYDtPP45P0RbHthJysr6EMBaIa1vOnqFzQmAGIw
         lV90ylsROmy8J6nqSihqEou9kzzxl1X/Rl52pKQxPd+e6XJUuM371VUuxLXRcZDDJ5Zr
         9Bb2FEcJHJDnRVloNx7ntigxbFa0dg5+evw5ZRVt3HY4E02wLO1DDSnQhyTTuACCjnJG
         brwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w0y9hW+FfwZmqRbEGDUn/tatRO/LwdPvsfhlv3Glf8s=;
        b=f230MkzOWu/SJDHo3CsTuhlvOGAT6+XOoyLfMOJuyhnZIgH8UxDjC1Ac6reJFV04Qy
         STNYsAqJx+pPnIWDq5Msuo4fzR8Pi8OUzbt0WSpLuDwBOuxeD4h6nZemG3MZL711tP4g
         kbh5wE558N1xDy8gjPuGfU15mnytWJ4N7zYdjSIct2ypR7N2276UrF0rGyHQjyBawRes
         5VTxcrt8oikWhokYRNELQ0CCapahsrqCrONA+8EByeXcsBim9uoK34UdNiKFe8K7LjIq
         TNIOZg53e3bsqV14fevSxhYg8sCZpXj4qoda86vnfMfkd+ph8VdnabzHXUmXty6IQGIg
         EjzQ==
X-Gm-Message-State: AHQUAuYN/F1iDpCx3A3f6XaH6ooe0MU6pypk10c8vSKnjGcq4Ynx05Ds
        3PludqLPrMXANVeBctydzc32IA==
X-Google-Smtp-Source: AHgI3IYFKbr0OJw7ra16rDwj01hO/nL0Ie5rDJ3B2Da4ACI0vdwlOV8s6fKzhRtr2bq49AsRzuru/w==
X-Received: by 2002:a63:d70e:: with SMTP id d14mr34732488pgg.159.1549908416674;
        Mon, 11 Feb 2019 10:06:56 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id a187sm9735052pfb.61.2019.02.11.10.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 10:06:55 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtFyo-0007co-W4; Mon, 11 Feb 2019 11:06:55 -0700
Date:   Mon, 11 Feb 2019 11:06:54 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
Message-ID: <20190211180654.GB24692@ziepe.ca>
References: <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <CAPcyv4hqya1iKCfHJRXQJRD4qXZa3VjkoKGw6tEvtWNkKVbP+A@mail.gmail.com>
 <bfe0fdd5400d41d223d8d30142f56a9c8efc033d.camel@redhat.com>
 <01000168c8e2de6b-9ab820ed-38ad-469c-b210-60fcff8ea81c-000000@email.amazonses.com>
 <20190208044302.GA20493@dastard>
 <20190208111028.GD6353@quack2.suse.cz>
 <CAPcyv4iVtBfO8zWZU3LZXLqv-dha1NSG+2+7MvgNy9TibCy4Cw@mail.gmail.com>
 <20190211102402.GF19029@quack2.suse.cz>
 <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iHso+PqAm-4NfF0svoK4mELJMSWNp+vsG43UaW1S2eew@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:22:58AM -0800, Dan Williams wrote:

> I honestly don't like the idea that random subsystems can pin down
> file blocks as a side effect of gup on the result of mmap. Recall that
> it's not just RDMA that wants this guarantee. It seems safer to have
> the file be in an explicit block-allocation-immutable-mode so that the
> fallocate man page can describe this error case. Otherwise how would
> you describe the scenarios under which FALLOC_FL_PUNCH_HOLE fails?

I rather liked CL's version of this - ftruncate/etc is simply racing
with a parallel pwrite - and it doesn't fail.

But it also doesnt' trucate/create a hole. Another thread wrote to it
right away and the 'hole' was essentially instantly reallocated. This
is an inherent, pre-existing, race in the ftrucate/etc APIs.

Jason
