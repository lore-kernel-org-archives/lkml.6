Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeB0KQO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:16:14 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:45111 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeB0KQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:16:12 -0500
Date: Tue, 27 Feb 2018 11:15:58 +0100 (CET)
From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
X-X-Sender: rolf@5HSWXM1.fritz.box
To: Kishon Vijay Abraham I <kishon@ti.com>
cc: Rolf Evers-Fischer <embedded24@evers-fischer.de>,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
Subject: Re: [PATCH v3 1/2] pci: endpoint: Simplify name allocation for epf
 device
In-Reply-To: <76904bbe-ebef-9b8f-5f30-e876f73b28fe@ti.com>
Message-ID: <alpine.LNX.2.20.1802271112310.22764@5HSWXM1.fritz.box>
References: <20180227100231.22561-1-embedded24@evers-fischer.de> <20180227100231.22561-2-embedded24@evers-fischer.de> <76904bbe-ebef-9b8f-5f30-e876f73b28fe@ti.com>
User-Agent: Alpine 2.20 (LNX 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tsRf9Uj9LTEslcyP9nr/flecs2K+OJJlhlKjwFsup7ZdRWHHZn3
 Zur+Opq5R+3swbDRuevmDfvhUkim6M2kyZs4FR9AAwG9JRXQkbVBjUTEjZFUL1/B//lOegw
 eMnssOzTlgeF6n1kDpLN5skGiV64vqtq1W3PXs2tFcpdPKynqrOSzh2DPDuz17XqUEc9uAV
 jKhxreFhdItxmL3kpyilg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GcqnpWomdhU=:GN2hm2n54D0Su8DI+lLRbV
 iJaSGk9c3/xu2CPOw0hSlgB3Ww8ILlGlUFC65BcWbbzOxKPy6bmUEUbsMSh2Hc5ZcoZhJJhNz
 +843TcFs/KTmI2hgg301ns+wBdxw04Xx5pXjrBtT5/JEWd9lcfmq+V0hRBrrOLRLdjyuZ1Xhz
 ujobIGPqaTGPttm6zjrifSBL3SdD3JfMuuLggZ58CQ/LFR1zp0jCLmhppDZ2fsbPeN3eEYkgq
 m5Jjp032MeZFGryaW6JqnlA4xJnrmCc3nB06Nerdl34PZyqxbRWvCsb80DFqQEw3hOOReZcaQ
 ni768zND9VSqsfZgtAVVHde2SHlIg/OBYufgu3rrnDYGnXZSuhqeQLHnNHAkyzWOdL8sc164W
 pEvmJ9Tihy/n70tZK4xdAxxAa00yy9tB5gvKf8MZ/w8sd7Lz2CVgnOey1JHtHzzwBipjK5DqS
 xn8+c9Onlfdz/52FgF5dloOCHAKOqU+noV1dTgR+x/nLEXR2XGTpsxPmVOx2RsSWsT23eLRoJ
 PucXh+GVdMFXbIIgcJLxd4AVND9p8QegiCs6GlJx3rA8MkNFuJu2+RVZpvbIgmW2g4yi5NWxk
 t/yPS+pr8rjSGZq+XCwO9LTfiptnnEgSerdYe0S0zbrSPL09D5urfIud8c816Cv3tpY1EY+F+
 BtTPTBnTlQBrGhvqE6CFzqOt0hyOwdZNEgw+sGsqLT9xnGli6RL9UxpEfE1Zi3W84b+3XpDwZ
 HCdAkIR6sFxlj47C0BQ36jpYn0GLnDfytCMGCTiMh5I3Ue8bk8d6GUkNhfY=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Feb 2018, Kishon Vijay Abraham I wrote:

> Hi,
> 
> On Tuesday 27 February 2018 03:32 PM, Rolf Evers-Fischer wrote:
> > From: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> > 
> > This commit replaces allocating and freeing the intermediate
> > 'buf'/'func_name' with a combination of 'kstrndup()' and 'len'.
> > 
> > 'len' is the required length of 'epf->name'.
> > 'epf->name' should be either the first part of 'name' preceding the '.'
> > or the complete 'name', if there is no '.' in the name.
> > 
> > Signed-off-by: Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>
> > ---
> >  drivers/pci/endpoint/pci-epf-core.c | 22 ++++------------------
> >  1 file changed, 4 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > index 766ce1dca2ec..1f2506f32bb9 100644
> > --- a/drivers/pci/endpoint/pci-epf-core.c
> > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > @@ -200,8 +200,7 @@ struct pci_epf *pci_epf_create(const char *name)
> >  	int ret;
> >  	struct pci_epf *epf;
> >  	struct device *dev;
> > -	char *func_name;
> > -	char *buf;
> > +	int len;
> >  
> >  	epf = kzalloc(sizeof(*epf), GFP_KERNEL);
> >  	if (!epf) {
> > @@ -209,20 +208,11 @@ struct pci_epf *pci_epf_create(const char *name)
> >  		goto err_ret;
> >  	}
> >  
> > -	buf = kstrdup(name, GFP_KERNEL);
> > -	if (!buf) {
> > -		ret = -ENOMEM;
> > -		goto free_epf;
> > -	}
> > -
> > -	func_name = buf;
> > -	buf = strchrnul(buf, '.');
> > -	*buf = '\0';
> > -
> > -	epf->name = kstrdup(func_name, GFP_KERNEL);
> > +	len = strchrnul(name, '.') - name;
> > +	epf->name = kstrndup(name, len, GFP_KERNEL);
> 
> shouldn't the string end with '\0'?
> 

I agree, it should end with '\0', but fortunately the 'kstrndup()' 
function already adds it for us, see mm/util.c, line 100:
	(...)
	memcpy(buf, s, len);
	buf[len] = '\0';
	(...)

Kind regards
 Rolf
