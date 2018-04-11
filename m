Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbeDKOJB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:09:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751541AbeDKOJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:09:00 -0400
Date: Wed, 11 Apr 2018 07:08:48 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Henders <hendersm@shaw.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] resource: Fix integer overflow at reallocation
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180408072026.27365-1-tiwai@suse.de>
 <20180409172326.944143fd13db2601e4dee9b0@linux-foundation.org>
 <s5hpo37d5l8.wl-tiwai@suse.de>
 <20180410134239.483fe34525db647f2f3d1ece@linux-foundation.org>
 <20180411003744.GC15890@ram.oc3035372033.ibm.com>
 <s5hefjmb73y.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hefjmb73y.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-TM-AS-GCONF: 00
x-cbid: 18041114-0040-0000-0000-0000042D1730
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041114-0041-0000-0000-000026312B40
Message-Id: <20180411140848.GD15890@ram.oc3035372033.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804110132
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 08:16:33AM +0200, Takashi Iwai wrote:
> On Wed, 11 Apr 2018 02:37:44 +0200,
> Ram Pai wrote:
> > 
> > On Tue, Apr 10, 2018 at 01:42:39PM -0700, Andrew Morton wrote:
> > > On Tue, 10 Apr 2018 06:54:11 +0200 Takashi Iwai <tiwai@suse.de> wrote:
> > > 
> > > > On Tue, 10 Apr 2018 02:23:26 +0200,
> > > > Andrew Morton wrote:
> > > > > 
> > > > > On Sun,  8 Apr 2018 09:20:26 +0200 Takashi Iwai <tiwai@suse.de> wrote:
> > > > > 
> > > > > > We've got a bug report indicating a kernel panic at booting on an
> > > > > > x86-32 system, and it turned out to be the invalid resource assigned
> > > > > > after PCI resource reallocation.  __find_resource() first aligns the
> > > > > > resource start address and resets the end address with start+size-1
> > > > > > accordingly, then checks whether it's contained.  Here the end address
> > > > > > may overflow the integer, although resource_contains() still returns
> > > > > > true because the function validates only start and end address.  So
> > > > > > this ends up with returning an invalid resource (start > end).
> > > > > > 
> > > > > > There was already an attempt to cover such a problem in the commit
> > > > > > 47ea91b4052d ("Resource: fix wrong resource window calculation"), but
> > > > > > this case is an overseen one.
> > > > > > 
> > > > > > This patch adds the validity check in resource_contains() to see
> > > > > > whether the given resource has a valid range for avoiding the integer
> > > > > > overflow problem.
> > > > > > 
> > > > > > ...
> > > > > >
> > > > > > --- a/include/linux/ioport.h
> > > > > > +++ b/include/linux/ioport.h
> > > > > > @@ -212,6 +212,9 @@ static inline bool resource_contains(struct resource *r1, struct resource *r2)
> > > > > >  		return false;
> > > > > >  	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
> > > > > >  		return false;
> > > > > > +	/* sanity check whether it's a valid resource range */
> > > > > > +	if (r2->end < r2->start)
> > > > > > +		return false;
> > > > > >  	return r1->start <= r2->start && r1->end >= r2->end;
> > > > > >  }
> > > > > 
> > > > > This doesn't look like the correct place to handle this?  Clearly .end
> > > > > < .start is an invalid state for a resource and we should never have
> > > > > constructed such a thing in the first place?  So adding a check at the
> > > > > place where this resource was initially created seems to be the correct
> > > > > fix?
> > > > 
> > > > Yes, that was also my first thought and actually the v1 patch was like
> > > > that.
> > > 
> > > Yes, I do prefer.
> > > 
> > > >  The v2 one was by Ram's suggestion so that we can cover
> > > > potential bugs by all other callers as well.
> > > 
> > > That could be done as a separate thing?
> > 
> > the first approach will fix overflows in just that particular case. The
> > second approach will catch and error-out overflows anywhere. There is a
> > short-term down side to the second approach; it might cause a slew of
> > error reports but will eventually help clean up all bad behavior.
> 
> For that purpose, maybe we should do in two folds: at first fix this
> specific issue in __find_resource(), then put the sanity check in
> resource_contains() in addition but with WARN_ON() so that we can
> catch more obviously.

Yes WARN_ON() is a better solution.

do the v1 way for this bug and replace the check in
resource_contains() to a WARN_ON() in a separate patch?

RP
