Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755389AbeE2IpP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:45:15 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48352 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755249AbeE2IpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:45:12 -0400
Date: Tue, 29 May 2018 11:45:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Auger Eric <eric.auger@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: remove a bogus cast in vfio_msi_set_block()
Message-ID: <20180529084502.hltdpojgnkjieaaj@mwanda>
References: <20180528074756.bgl5fxvn7foe5uhn@kili.mountain>
 <8df5c218-cc97-3dbc-e820-f8bdc710ac17@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8df5c218-cc97-3dbc-e820-f8bdc710ac17@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8907 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805290102
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 09:27:18PM +0200, Auger Eric wrote:
> Hi Dan,
> 
> On 05/28/2018 09:47 AM, Dan Carpenter wrote:
> > This cast is confusing...  The "start" variable is an unsigned int.  We
> > absolutely do not want to cast it to a negative int so why is the cast
> > there?  It turns out, when you look at the context, it's a no-op and we
> > can just remove it.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> > index 1c46045b0e7f..2724fed62129 100644
> > --- a/drivers/vfio/pci/vfio_pci_intrs.c
> > +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> > @@ -368,7 +368,7 @@ static int vfio_msi_set_block(struct vfio_pci_device *vdev, unsigned start,
> >  	}
> >  
> >  	if (ret) {
> > -		for (--j; j >= (int)start; j--)
> > +		for (--j; j >= start; j--)
> I think this was done one purpose as j can be -1 while start is an
> unsigned.
> 

Oh, wow...  Yeah.  Sorry.  I didn't think that through.  I will create
a static checker warning so this particular bug doesn't happen to me
again.

regards,
dan carpenter
