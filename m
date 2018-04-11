Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753943AbeDKQQW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:16:22 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35650 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752798AbeDKQQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:16:21 -0400
Message-ID: <1523463379.3221.18.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] dec: tulip: de4x5: Replace mdelay with usleep_range
 in de4x5_hw_init
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>, davem@davemloft.net,
        stephen@networkplumber.org, johannes.berg@intel.com,
        arvind.yadav.cs@gmail.com, dhowells@redhat.com
Cc: netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 11 Apr 2018 09:16:19 -0700
In-Reply-To: <1523461182-5897-1-git-send-email-baijiaju1990@gmail.com>
References: <1523461182-5897-1-git-send-email-baijiaju1990@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-11 at 23:39 +0800, Jia-Ju Bai wrote:
> de4x5_hw_init() is never called in atomic context.
> 
> de4x5_hw_init() is only called by de4x5_pci_probe(), which is only 
> set as ".probe" in struct pci_driver.
> 
> Despite never getting called from atomic context, de4x5_hw_init() 
> calls mdelay() to busily wait. This is not necessary and can be
> replaced with usleep_range() to  avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.

Did you actually test this?  The usual reason for wanting m/udelay is
that the timing must be exact.  The driver is filled with mdelay()s for
this reason.  The one you've picked on is in the init path so it won't
affect the runtime in any way.  I also don't think we have the hrtimer
machinery for usleep_range() to work properly on parisc, so I don't
think the replacement works.

James
