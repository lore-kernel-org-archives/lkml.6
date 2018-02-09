Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbeBILLP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 06:11:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750970AbeBILLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 06:11:13 -0500
Date: Fri, 9 Feb 2018 13:11:03 +0200
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 1/2] zsmalloc: introduce zs_huge_object() function
References: <20180207092919.19696-1-sergey.senozhatsky@gmail.com>
 <20180207092919.19696-2-sergey.senozhatsky@gmail.com>
 <20180208163006.GB17354@rapoport-lnx>
 <20180209025520.GA3423@jagdpanzerIV>
 <20180209041046.GB23828@bombadil.infradead.org>
 <20180209053630.GC689@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209053630.GC689@jagdpanzerIV>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18020911-0016-0000-0000-000005211F71
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020911-0017-0000-0000-0000285DDC37
Message-Id: <20180209111102.GB2044@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802090143
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2018 at 02:36:30PM +0900, Sergey Senozhatsky wrote:
> On (02/08/18 20:10), Matthew Wilcox wrote:
> [..]
> > Examples::
> > 
> >   * Context: Any context.
> >   * Context: Any context. Takes and releases the RCU lock.
> >   * Context: Any context. Expects <lock> to be held by caller.
> >   * Context: Process context. May sleep if @gfp flags permit.
> >   * Context: Process context. Takes and releases <mutex>.
> >   * Context: Softirq or process context. Takes and releases <lock>, BH-safe.
> >   * Context: Interrupt context.
> 
> I assume that  <mutex>  spelling serves as a placeholder and should be
> replaced with a lock name in a real comment. E.g.
> 
> 	Takes and releases audit_cmd_mutex.
> 
> or should it actually be
> 
> 	Takes and releases <audit_cmd_mutex>.
> 
> 
> 
> 
> So below is zs_huge_object() documentation I came up with:
>
> ---
> 
> +/**
> + * zs_huge_object() - Test if a compressed object's size is too big for normal
> + *                    zspool classes and it will be stored in a huge class.

Maybe "it should be stored ..."?

> + * @sz: Size in bytes of the compressed object.
> + *
> + * The functions checks if the object's size falls into huge_class area.
> + * We must take ZS_HANDLE_SIZE into account and test the actual size we

                ^ %ZS_HANDLE_SIZE

> + * are going to use up, because zs_malloc() unconditionally adds the

I think 's/use up/use/' here

> + * handle size before it performs size_class lookup.

                                   ^ &size_class
> + *
> + * Context: Any context.
> + *
> + * Return:
> + * * true  - The object's size is too big, it will be stored in a huge class.
> + * * false - The object will be store in normal zspool classes.
> + */
> ---
> 
> looks OK?
> 
> 	-ss
> 

-- 
Sincerely yours,
Mike.
