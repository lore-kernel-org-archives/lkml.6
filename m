Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeCIHym (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 02:54:42 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42787 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbeCIHyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 02:54:40 -0500
X-Google-Smtp-Source: AG47ELv40GE7fk8msdKLxdiGX8pl2OQ9Lhk4bopJTbZQ6zsmA0MbBTIyz9/WfNZarq0Za2mDhTuJ2g==
Date: Fri, 9 Mar 2018 08:54:36 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] x86: efi: Replace GFP_ATOMIC with GFP_KERNEL in
 efi_query_variable_store
Message-ID: <20180309075436.tedbueuh3wuocr3p@gmail.com>
References: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
 <20180308080020.22828-7-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308080020.22828-7-ard.biesheuvel@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> From: Jia-Ju Bai <baijiaju1990@gmail.com>
> 
> The function kzalloc here is not called in atomic context.
> If nonblocking in efi_query_variable_store is true,
> namely it is in atomic context, efi_query_variable_store will return before
> this kzalloc is called.
> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.

Please fix typos/spelling in changelogs when applying patches.

I improved the above to:

  efi_query_variable_store() does an atomic kzalloc() unnecessarily,
  because we can never get this far when called in an atomic context,
  namely when nonblocking == 1.

  Replace it with GFP_KERNEL.

  This was found by the DCNS static analysis tool written by myself.

Thanks,

	Ingo
