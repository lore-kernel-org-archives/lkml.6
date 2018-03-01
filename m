Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031637AbeCAOvO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:51:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1031618AbeCAOvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:51:12 -0500
Subject: Re: [PATCH 1/1] vfio-ccw: fence off transport mode
To: Cornelia Huck <cohuck@redhat.com>,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180222153959.31272-1-cohuck@redhat.com>
 <20180222153959.31272-2-cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 15:51:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222153959.31272-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030114-0008-0000-0000-000004D67DC8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030114-0009-0000-0000-00001E698283
Message-Id: <95c1554e-ada3-f6db-62aa-f04e42a0ae09@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010187
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/22/2018 04:39 PM, Cornelia Huck wrote:
> vfio-ccw only supports command mode for channel programs, not transport
> mode. User space is supposed to already take care of that and pass us
> command-mode ORBs only, but better make sure and return an error to
> the caller instead of trying to process tcws as ccws.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>

> ---
>  drivers/s390/cio/vfio_ccw_fsm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> index c30420c517b1..ff6963ad6e39 100644
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -124,6 +124,11 @@ static void fsm_io_request(struct vfio_ccw_private *private,
>  	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
>  		orb = (union orb *)io_region->orb_area;
> 
> +		/* Don't try to build a cp if transport mode is specified. */
> +		if (orb->tm.b) {
> +			io_region->ret_code = -EOPNOTSUPP;

I guess now we communicate this as appropriately as possible.

> +			goto err_out;
> +		}
>  		io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev),
>  					      orb);
>  		if (io_region->ret_code)
> 
