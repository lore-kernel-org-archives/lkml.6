Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752511AbeDDWfz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 18:35:55 -0400
Received: from mout.web.de ([212.227.15.3]:56525 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752286AbeDDWfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 18:35:53 -0400
Subject: Re: [PATCH v7 2/5] of: change overlay apply input data from
 unflattened to FDT
To: frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>,
        pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, laurent.pinchart+renesas@ideasonboard.com,
        Jailhouse <jailhouse-dev@googlegroups.com>
References: <1520122673-11003-1-git-send-email-frowand.list@gmail.com>
 <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Openpgp: preference=signencrypt
Message-ID: <09e3db63-cbf9-52a2-ee77-520979f17fea@web.de>
Date: Thu, 5 Apr 2018 00:35:42 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <1520122673-11003-3-git-send-email-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:O/ZrMP0Nkt/8JTdpvFvi6CALUi3uJxs1KoPUt7j7VsnPzw5oaci
 mV6eAVYLO2XkEYyDlYJMj1y30UB7OgZfTfuUFLfBoxPqde+fi9qpDpQnZri+GI0BbqEwUQ3
 4GNcRIgTdkFHDCNn0bHAwmVs5DSN9q0tXKOHO+oCg6bG0gJK1Tqe09Paxh1YZUYPeKD5Rn7
 hTD5KdHRxlemuZZVsSh2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TB68PhU+HHs=:rqwmeIwNzEfKFTKXFKGh3h
 0E+4uL3EV152gR1z/BDpGDGdJebL2Yi7E5qKsmZuX54o5/DrF7JWzCW6IKM4hQtdVJBFIca5P
 ooZ8qpbv5VS68hzsOfkhaMhKanJN/mhyvKz9/9rCX7fAIVDk7Et8M9cK8Hky1EvFxfxpP6KjL
 2nwMnK01/D1WVYpumM7zRjte7VaT8jvWbSJtZblAdOq7ef94RpGZ6zI2iyiV6Gdl/Wst94NRs
 I0mbCr7p30ZSGzDy+BkiLzFt9MAor/zlMfRxVKqGHIjaaFTaLNFRfIHod46PIwX6mXdDhfz4y
 T4uPwr4ObyPbpN41GrpZEQqmCujLMXkftCrGOuWVu6eRW0D9lPrM2M5sUEVPsai05viAP/enD
 NUNvdqeURHlQ3YXKQdYTvW6F1hOfv0psHOq8QBAruprPE30oRPs541Rrcyc+c79px87zv2Yz2
 j0j9GcPy+8HF/qDUXxV6qaLOSEEa3ddRgdo6+44+pbEbuhcsVcqH+gcPXpFBRd4tFhvX5F7cq
 Tbo7YVBFWHGXLWauETAvbvO0DHQLdZ0aGk4V9Des0OVCsKXpesewhzzXGtkov7mt8SXWEGldz
 v0nEHVeknF8qcsCcNPJnj7n+ijXfvXS/Hru4d6QWKUrcp5Je0W9viixZ96/g6EED44wQIGhuM
 AQwgvtidvtHFT9yGfqIQW5m6iQtluOKGpbieEX7ZVhzFsjLKZVoVxWfEBcCXXg3IjViNdqojm
 o0tOIL+s5zySN7hP9mYE6Kc/ZFCPZA+5wX/c6IbQVOCbHgUB6ixR98GR76DFZ3L318PPKpbFS
 6U6T/wPDQthHhTg7vIol4Tav/6WD830AapLKy6kFF3OKsxmAZw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On 2018-03-04 01:17, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> Move duplicating and unflattening of an overlay flattened devicetree
> (FDT) into the overlay application code.  To accomplish this,
> of_overlay_apply() is replaced by of_overlay_fdt_apply().
> 
> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
> code, which is thus responsible for freeing the duplicate FDT.  The
> caller of of_overlay_fdt_apply() remains responsible for freeing the
> original FDT.
> 
> The unflattened devicetree now belongs to devicetree code, which is
> thus responsible for freeing the unflattened devicetree.
> 
> These ownership changes prevent early freeing of the duplicated FDT
> or the unflattened devicetree, which could result in use after free
> errors.
> 
> of_overlay_fdt_apply() is a private function for the anticipated
> overlay loader.

We are using of_fdt_unflatten_tree + of_overlay_apply in the
(out-of-tree) Jailhouse loader driver in order to register a virtual
device during hypervisor activation with Linux. The DT overlay is
created from a a template but modified prior to application to account
for runtime-specific parameters. See [1] for the current implementation.

I'm now wondering how to model that scenario best with the new API.
Given that the loader lost ownership of the unflattened tree but the
modification API exist only for the that DT state, I'm not yet seeing a
clear solution. Should we apply the template in disabled form (status =
"disabled"), modify it, and then activate it while it is already applied?

Thanks,
Jan

[1]
https://github.com/siemens/jailhouse/blob/11ef401a9064644bf7faf28e35c97f27ececd81d/driver/pci.c#L280
