Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeFAIQs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:16:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeFAIQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:16:44 -0400
Date: Fri, 1 Jun 2018 01:16:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
Cc: Milan Broz <gmazyland@gmail.com>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Manjunath M Bettegowda <Manjunath.MB@synopsys.com>,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        device-mapper development <dm-devel@redhat.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] md: dm-crypt: Add Inline Encryption support for dmcrypt
Message-ID: <20180601081642.GA25973@infradead.org>
References: <e9120efc-1e25-79c8-6132-9062dd030539@synopsys.com>
 <7a510610-9133-39aa-6841-3925c532f3c0@gmail.com>
 <BD7FB879CC136E419544C8E2AE7B9C3020BB94@IN01WEMBXA.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD7FB879CC136E419544C8E2AE7B9C3020BB94@IN01WEMBXA.internal.synopsys.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 02:52:07PM +0000, Ladvine D Almeida wrote:
> when the optional argument "perform_inline_encrypt" is set, we are not unconditionally sending the bio
> to the block devices. The steps are explained below:
> 1. user invokes the dm-setup command with the registered cipher "xts" and with the optional argument
> "perform_inline_encrypt".
> 2. dm-setup invokes the setkey function of the newly introduced algorithm, which finds the available key slots
> to be programmed(UFS Host controller Inline Encryption engine has multiple keyslots), program the key slot,
> and return the key slot index as return value of the set key function.
> 3. When read/write operation happens, crypt_map() function in dm-crypt validates whether there is associated
> key configuration index for the request. The Bio will be submitted directly in this case only with the associated
> crypto context.
> 4. Block device driver, eg. UFS host controller driver will create the Transfer requests as per this crypto context and
> encryption happens inside the controller.

Why isn't this all controlled by the ufs drivers, using helpers as
required?

Also why do we even need this API over just implementing TCG
Opal/Opalite on the device?
