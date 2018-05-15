Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeEOTkB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 15:40:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48330 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeEOTj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 15:39:59 -0400
Date: Tue, 15 May 2018 22:39:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] media: tm6000: fix potential Spectre variant 1
Message-ID: <20180515193936.m25kzyeknsk2bo2c@mwanda>
References: <3d4973141e218fb516422d3d831742d55aaa5c04.1524499368.git.gustavo@embeddedor.com>
 <20180423152455.363d285c@vento.lan>
 <3ab9c4c9-0656-a08e-740e-394e2e509ae9@embeddedor.com>
 <20180423161742.66f939ba@vento.lan>
 <99e158c0-1273-2500-da9e-b5ab31cba889@embeddedor.com>
 <20180426204241.03a42996@vento.lan>
 <df8010f1-6051-7ff4-5f0e-4a436e900ec5@embeddedor.com>
 <20180515085953.65bfa107@vento.lan>
 <20180515141655.idzuh2jfdkuu5grs@mwanda>
 <f342d8d6-b5e6-0cbf-d002-9561b79c90e4@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f342d8d6-b5e6-0cbf-d002-9561b79c90e4@embeddedor.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8894 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=951
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150191
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 12:29:10PM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 05/15/2018 09:16 AM, Dan Carpenter wrote:
> > > > 
> > > > I'm curious about how you finally resolved to handle these issues.
> > > > 
> > > > I noticed Smatch is no longer reporting them.
> > > 
> > > There was no direct fix for it, but maybe this patch has something
> > > to do with the smatch error report cleanup:
> > > 
> > > commit 3ad3b7a2ebaefae37a7eafed0779324987ca5e56
> > > Author: Sami Tolvanen <samitolvanen@google.com>
> > > Date:   Tue May 8 13:56:12 2018 -0400
> > > 
> > >      media: v4l2-ioctl: replace IOCTL_INFO_STD with stub functions
> > >      This change removes IOCTL_INFO_STD and adds stub functions where
> > >      needed using the DEFINE_V4L_STUB_FUNC macro. This fixes indirect call
> > >      mismatches with Control-Flow Integrity, caused by calling standard
> > >      ioctls using a function pointer that doesn't match the function type.
> > >      Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > >      Signed-off-by: Hans Verkuil <hansverk@cisco.com>
> > >      Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > 
> 
> Thanks, Mauro.
> 
> > 
> > Possibly...  There was an ancient bug in Smatch's function pointer
> > handling.  I just pushed a fix for it now so the warning is there on
> > linux-next.
> > 
> 
> Dan,
> 
> These are all the Spectre media issues I see smatch is reporting in
> linux-next-20180515:
> 
> drivers/media/cec/cec-pin-error-inj.c:170 cec_pin_error_inj_parse_line()
> warn: potential spectre issue 'pin->error_inj_args'
> drivers/media/dvb-core/dvb_ca_en50221.c:1479 dvb_ca_en50221_io_write() warn:
> potential spectre issue 'ca->slot_info' (local cap)
> drivers/media/dvb-core/dvb_net.c:252 handle_one_ule_extension() warn:
> potential spectre issue 'p->ule_next_hdr'
> 
> I pulled the latest changes from the smatch repository and compiled it.
> 
> I'm running smatch v0.5.0-4459-g2f66d40 now. Is this the latest version?
> 
> I wonder if there is anything I might be missing.
> 

You'd need to rebuild the db (possibly twice but definitely once).

regards,
dan carpenter
