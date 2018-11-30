Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0989C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BF320666
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BF320666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeK3Otd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:49:33 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:42448 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeK3Otc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:49:32 -0500
Received: by mail-pl1-f179.google.com with SMTP id x21-v6so2088449pln.9;
        Thu, 29 Nov 2018 19:41:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nFnDd3gn/WidIIBd27QTHp2nFj0t46IyC9Z/42HODpY=;
        b=TksR3FKYjxBeTS/AvOx7iSqw/PqkoFpvt/lijRyicH97z6u0dMLGWwlOTzS/rTpORW
         YNg9RtpHHSa+FsgldxmyREo/9xNB8ziwo1R/N9Idt7kJXZgh4UsHULw3+b+vNX1rX/Gp
         FGI8DdCpib3Z9o4dEzLU6X8Aoa67qwDYSQHhNBklOBulk9XHuz3ewXGe3l3lxn50Nm/K
         4HomWdKYKMmfFvXw5NOyO666lnF44W63d8MHWjUR9pBr7BytUeBGoIM05YGJMICXBhGM
         EmGl7LdEyQcA/DDoDiAwbXmFRNyf3QQCoGUz51M5dEOLGJFLDYTqU6gse6655pIRNRqn
         lNeg==
X-Gm-Message-State: AA+aEWbeARLMotw8Uvup9Jfd/dzsmET5B61HZToUkpF1HKM2QUwgVOGn
        DaIHSIz5De1MeXe7K1BMjyc=
X-Google-Smtp-Source: AFSGD/UlYW8KhS09P1Y1q+f8Z0qSK+LIaI0ElcRJ86xQ8lzU9BJCyc5l7PZ0KHTGv04xylrz4tTFCA==
X-Received: by 2002:a17:902:6ac3:: with SMTP id i3-v6mr4098250plt.153.1543549300726;
        Thu, 29 Nov 2018 19:41:40 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id y5sm5274106pge.49.2018.11.29.19.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 19:41:39 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 29 Nov 2018 19:41:35 -0800
Date:   Thu, 29 Nov 2018 19:41:35 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     gregkh@linuxfoundation.org, keescook@google.com, shuah@kernel.org,
        joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com,
        knut.omang@oracle.com
Subject: Re: [RFC v3 08/19] arch: um: add shim to trap to allow installing a
 fault catcher for tests
Message-ID: <20181130034135.GN18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-9-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128193636.254378-9-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 11:36:25AM -0800, Brendan Higgins wrote:
> +static void segv_run_catcher(jmp_buf *catcher, void *fault_addr)
> +{
> +	current->thread.fault_addr = fault_addr;
> +	UML_LONGJMP(catcher, 1);
> +}

Some documentation about what this does exactly would be appreciated.
With the goal it may be useful to others wanting to consider support
for other archs -- if that actually ends up being desirable.

  Luis
