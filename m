Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964987AbeEXHVW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:21:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964885AbeEXHVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:21:19 -0400
Date: Thu, 24 May 2018 00:21:04 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>, robh@kernel.org,
        aik@ozlabs.ru, jasowang@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org,
        joe@perches.com, linuxppc-dev@lists.ozlabs.org,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au
Subject: Re: [RFC V2] virtio: Add platform specific DMA API translation for
 virito devices
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180522063317.20956-1-khandual@linux.vnet.ibm.com>
 <20180523213703-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180523213703-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18052407-0008-0000-0000-000004FA92B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052407-0009-0000-0000-00001E8E995A
Message-Id: <20180524072104.GD6139@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240090
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 09:50:02PM +0300, Michael S. Tsirkin wrote:
> subj: s/virito/virtio/
> 
..snip..
> >  machine_subsys_initcall_sync(pseries, tce_iommu_bus_notifier_init);
> > +
> > +bool platform_forces_virtio_dma(struct virtio_device *vdev)
> > +{
> > +	/*
> > +	 * On protected guest platforms, force virtio core to use DMA
> > +	 * MAP API for all virtio devices. But there can also be some
> > +	 * exceptions for individual devices like virtio balloon.
> > +	 */
> > +	return (of_find_compatible_node(NULL, NULL, "ibm,ultravisor") != NULL);
> > +}
> 
> Isn't this kind of slow?  vring_use_dma_api is on
> data path and supposed to be very fast.

Yes it is slow and not ideal. This won't be the final code. The final
code will cache the information in some global variable and used
in this function.

However this code was added to the RFC to illustrate the idea that dma
operation are needed only in a secure/protected environment.

RP
