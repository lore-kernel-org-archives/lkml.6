Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932065AbeB1K35 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:29:57 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:45727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbeB1K3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:29:54 -0500
Date: Wed, 28 Feb 2018 11:29:41 +0100 (CET)
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
X-X-Sender: rolf@5HSWXM1.fritz.box
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
cc: Rolf Evers-Fischer <embedded24@evers-fischer.de>, kishon@ti.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: Re: [PATCH v3 2/2] pci: endpoint: Fix kernel panic after
 put_device()
In-Reply-To: <20180227175756.GB12756@e107981-ln.cambridge.arm.com>
Message-ID: <alpine.LNX.2.20.1802281122100.29501@5HSWXM1.fritz.box>
References: <20180227100231.22561-1-embedded24@evers-fischer.de> <20180227100231.22561-3-embedded24@evers-fischer.de> <20180227175756.GB12756@e107981-ln.cambridge.arm.com>
User-Agent: Alpine 2.20 (LNX 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ls6qflnHy2CDB8QsbyQqN22kPDvyP5oy4xoubREtDLn+nUgpnsl
 pe3g434vF41OFv5+Q5cR62czfcLeksyUuhDhYTQSFUFncykbRq1y9SBXz8h3OtJDwZSV4H3
 piQeQviIcggEtFTyKSr+Dy68K8qiWu57RvWeU+BM1LaG77JpasC8xEfIvdAsifMAWcH/gnQ
 yC5invDh3yo+CgmmiJtEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gzveLpzt6no=:mWFQhKLhs+pQoltwlJxB9b
 oiEhwqdIpAGkSJDe5YWivfW3IR6O/04mMOX6u8OxYAVbbiydB8hzLnk6bxmVzYdd44ZRpicAG
 HfRBahs1XN0HGiwBUb0q9DbFdCtM+OVO2vQQZkOJEtA9rpONvXNjmx9tjUrmPoZjwhyyUGU4E
 jx42eeNANP9Egd6JRKr/bjJ2TwTfX2zhQQxn2HnHl8h6iYDzs9Zg5hcYyP5s316dq2nUoV85K
 1f5y022AKuFe+Pp3jXs0k4/seHJeo1GEwOZie/Cdszg6g2N7X/oQvaYbRYlavM6V7Ob8m7gY6
 KH5zWCbQDjPoSocrAWCevay6cfxS8r4I+JfKYVZKa9qmzpBqvRShZZejM9i5qaiSP1Uqo0HPu
 /zCshK0MQLGt0GvEVT+o3Z/rRHhyRND2B4poS+WEZu3m1v7aa/akng9dxJlQxnPKGKllll3ZJ
 e1GKIMU6m8soE+BbueOiaJewwP2k2OSE0F5BkIMbK+/drXR04SfVixqB5SxBXZkPz5Ijim3g/
 j9uwElYPpdl4I4wJGyuboiTV3KvnkQDFEUtMSSKfq7B4Ty67xrFC53OiP0lekiR6GOAtG3MPk
 IVclvIJ1cCxAlA2w9Zgdlxy14/+J8wVOhWrteaP0h35ShDR4ksz40fu3sqIWnx2I1Hq6Oz66Z
 rlCLuoY86sVMG2BY6yGDbGx8Lx5H0wAAxsKlNQhis6p1fDA7N2SLN5E/t0P7PB/9CI8lvDjog
 MQDz+DO+gtXk/Sz9m3/aY9mTmDYst246vDr6WRMWxVqd3rBS/Caad7i7zms=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lorenzo!

On Tue, 27 Feb 2018, Lorenzo Pieralisi wrote:

> On Tue, Feb 27, 2018 at 11:02:30AM +0100, Rolf Evers-Fischer wrote:
> > From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> > 
> > 'put_device()' calls the relase function 'pci_epf_dev_release()',
> > which already frees 'epf->name' and 'epf'.
> > 
> > Therefore we must not free them again after 'put_device()'.
> > 
> > Fixes: 5e8cb4033807 ("PCI: endpoint: Add EP core layer to enable EP controller and EP functions")
> > 
> > Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> > ---
> >  drivers/pci/endpoint/pci-epf-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > index 1f2506f32bb9..1878a6776519 100644
> > --- a/drivers/pci/endpoint/pci-epf-core.c
> > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > @@ -232,7 +232,7 @@ struct pci_epf *pci_epf_create(const char *name)
> >  
> >  put_dev:
> >  	put_device(dev);
> > -	kfree(epf->name);
> > +	return ERR_PTR(ret);
> 
> Another thing you could do, which would get rid of these multiple return
> statements (yes there is another one) would consist in removing the goto
> labels completely and handle the errors at the respective call site and
> just return instead of jumping around.
> 

Thank you for sharing this idea! I've already changed it locally and it 
seems that we can get rid of 11 code lines with that.
It is being verified. If it really works, there will be a new commit
soon.

Kind regards,
 Rolf
