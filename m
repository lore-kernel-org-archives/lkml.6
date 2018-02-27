Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752916AbeB0MMK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 07:12:10 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:43921 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbeB0MMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 07:12:09 -0500
Date: Tue, 27 Feb 2018 13:11:57 +0100 (CET)
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
X-X-Sender: rolf@5HSWXM1.fritz.box
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
cc: Rolf Evers-Fischer <embedded24@evers-fischer.de>, kishon@ti.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 0/2] pci: endpoint: Fix double free in
 pci_epf_create()
In-Reply-To: <20180227102030.GB26238@e107981-ln.cambridge.arm.com>
Message-ID: <alpine.LNX.2.20.1802271257030.23086@5HSWXM1.fritz.box>
References: <20180227100231.22561-1-embedded24@evers-fischer.de> <20180227102030.GB26238@e107981-ln.cambridge.arm.com>
User-Agent: Alpine 2.20 (LNX 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bQkVowVh6YOvH8EaB07TVqbYTUG5gjugSiXK/u05J4mKTSHhjWb
 SdObO6RLpCkGzhIZVwSoSdVLgJSiqUO8P2hrCEePpwtuxCpM1IURvtNnVNH844LNeRLZZvw
 rHQlPB+VT/ExfF46ftAvWnMVO8Zbl7MPParcjoc82qjkCfCIZ+fHbR1ULW6mJLc27hTNP0S
 x/6pr90AWULfTj1/67odA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6YPkXytaio4=:me/ZrUe5GEGMvk+RIK5V7z
 FJWaTfi+ZnYfsq7211hVh0tQDbkXAk7yGEsMycC9arIC2YtY4B5rDp9s+EwG4QayAJ6I0uLYM
 pdXafMWBXemsvzyL0TbLg/+yoXZykk6d60sy1Iv7Kx9rqOHFyeFxOF9g6YSHdD/YmkZBM5ba2
 buU1B+URuZisW9Ah1jV7qYS+L7kPM/LpYWV9G+4H6DB9mhaJC5d3S2rQ3tX2AsTfMGO5a+Uwe
 MswAmmKN3JPrF4Ifjx8SFmVJgJHJ1WpKUgVLlswr0lNI1oeUzWUzVNtdb0jm0q8hMbEQAGUoi
 EL6hZ0ObYLzicsLnWkjcopyW4qxWlamG0pn5muucS5/k/G29/Dz4GVLmqAQTr0oOfkExIErjD
 j50fUJHiUFsHfQ2xUBE2jccBSOR2NJczHyCxTsZiGYnViXOHZ/vSy/z7emUU6lzByC4KXR4Db
 a+O9yC8NLkiumJKchOX32KPE9R44hNxPqiAmDt+Glsjgh4UE6g3MawK60dOnnIU4zDoiqoJOO
 JHbNtlFLymJQaC7gDpS68dD1u3/qky9YQnfaKMejY9hxlfb4JUHf+9vbKRbem3/ad1HwxBKEn
 lSuhORT/gTk02nRoVCTI9qtbew2GAWkqHLkHIelXx08REqj6h63K5dPWCD62BqdMgna1bpD3p
 J1p6f9o1mwP65cwOyj7wKh6xhmRE4ZYheWruffMi+1XfT+c70vFzgC0lxem6bOHmdzFOVtg2V
 QpMaPGqwhvc4VNNrrlp0E/vcU5IiR4x2ZSKVWUROAKojPe8SGRFWYUZ8bwY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lorenzo,

On Tue, 27 Feb 2018, Lorenzo Pieralisi wrote:

> On Tue, Feb 27, 2018 at 11:02:28AM +0100, Rolf Evers-Fischer wrote:
> > This is version 3 of a patchset to avoid double free in function
> > 'pci_epf_create()'.
> > 
> > When I accidentally created a new endpoint device with an empty name,
> > the kernel warned about "attempted to be registered with empty name!"
> > and crashed afterwards.
> > 
> > It turned out that the crash was not caused by the 'device_add()'
> > function itself, but by a double kfree of 'epf->name' and 'epf'.
> > 
> > The first patch just simplifies the code, while the second patch
> > fixes the problem.
> > 
> > Changes in v3:
> > - Matched to other pending pci endpoint commits (thanks, Bjorn!)
> > - Added "Fixes" tag in patch 2 (thanks, Andy!)
> > 
> > Changes in v2:
> > - Based on feedback from Lorenzo, Andy and Kishon (thanks!)
> > - Change IDs removed
> > - First patch completely reworked in order to eliminate the
> >   need for the second 'kstrdup' allocation and the 'kfree' of
> >   the first allocation.
> >   It was tested with name="pci_epf_test.0" and name="pci_epb":
> >   The 'epf->name' was "pci_epf_test" or "pci_epb" (=unchanged).
> > 
> > Rolf Evers-Fischer (2):
> >   pci: endpoint: Simplify name allocation for epf device
> >   pci: endpoint: Fix kernel panic after put_device()
>     ^^^
> 
> s/pci/PCI
> 
> Bjorn pointed that out too, I can do it when merging the patches myself
> just a hint in case you have to respin it again, no problem.
> 

thank you for pointing this out. I haven't recognized this detail. I 
thought that Bjorn wanted me to rebase my patch series upon the latest 
unmerged PCI endpoint patches - and I was surprised that there was no 
change.

Thank you for your kind offer to fix it when merging the patches.

Best regards,
 Rolf
