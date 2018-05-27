Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032643AbeE0Mre (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 08:47:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S936343AbeE0Mrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 08:47:31 -0400
Date: Sun, 27 May 2018 15:47:22 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Michal Hocko <mhocko@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] doc: document scope NOFS, NOIO APIs
References: <20180424183536.GF30619@thunk.org>
 <20180524114341.1101-1-mhocko@kernel.org>
 <20180524221715.GY10363@dastard>
 <20180525081624.GH11881@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525081624.GH11881@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18052712-0040-0000-0000-0000043E481E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052712-0041-0000-0000-000026438EC2
Message-Id: <20180527124721.GA4522@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805270160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 10:16:24AM +0200, Michal Hocko wrote:
> On Fri 25-05-18 08:17:15, Dave Chinner wrote:
> > On Thu, May 24, 2018 at 01:43:41PM +0200, Michal Hocko wrote:
> [...]
> > > +FS/IO code then simply calls the appropriate save function right at the
> > > +layer where a lock taken from the reclaim context (e.g. shrinker) and
> > > +the corresponding restore function when the lock is released. All that
> > > +ideally along with an explanation what is the reclaim context for easier
> > > +maintenance.
> > 
> > This paragraph doesn't make much sense to me. I think you're trying
> > to say that we should call the appropriate save function "before
> > locks are taken that a reclaim context (e.g a shrinker) might
> > require access to."
> > 
> > I think it's also worth making a note about recursive/nested
> > save/restore stacking, because it's not clear from this description
> > that this is allowed and will work as long as inner save/restore
> > calls are fully nested inside outer save/restore contexts.
> 
> Any better?
> 
> -FS/IO code then simply calls the appropriate save function right at the
> -layer where a lock taken from the reclaim context (e.g. shrinker) and
> -the corresponding restore function when the lock is released. All that
> -ideally along with an explanation what is the reclaim context for easier
> -maintenance.
> +FS/IO code then simply calls the appropriate save function before any
> +lock shared with the reclaim context is taken.  The corresponding
> +restore function when the lock is released. All that ideally along with

Maybe: "The corresponding restore function is called when the lock is
released"

> +an explanation what is the reclaim context for easier maintenance.
> +
> +Please note that the proper pairing of save/restore function allows nesting
> +so memalloc_noio_save is safe to be called from an existing NOIO or NOFS scope.
 
so it is safe to call memalloc_noio_save from an existing NOIO or NOFS
scope

>  What about __vmalloc(GFP_NOFS)
>  ==============================
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.
