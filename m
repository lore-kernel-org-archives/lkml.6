Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeEGMU3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 08:20:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:8565 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751005AbeEGMU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 08:20:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,373,1520924400";
   d="scan'208";a="226463820"
Date: Mon, 7 May 2018 15:20:24 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Yehezkel Bernat <yehezkelshb@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>, michael.jamet@intel.com
Subject: Re: [PATCH v2] thunderbolt: Handle NULL boot ACL entries properly
Message-ID: <20180507122024.GA2879@lahna.fi.intel.com>
References: <20180430111245.31072-1-mika.westerberg@linux.intel.com>
 <CA+CmpXtiJx=Ufk6tdZOa+4m3uLiR3KoY1hknWmBZ5c0AUg6yEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CmpXtiJx=Ufk6tdZOa+4m3uLiR3KoY1hknWmBZ5c0AUg6yEQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 06:56:13PM +0000, Yehezkel Bernat wrote:
> On Mon, Apr 30, 2018 at 2:12 PM Mika Westerberg <
> mika.westerberg@linux.intel.com> wrote:
> 
> > If the boot ACL entry is already NULL we should not fill in the upper
> > two DWs with 0xfffffffff. Otherwise they are not shown as empty entries
> > when the sysfs attribute is read.
> 
> > Fixes: 9aaa3b8b4c56 ("thunderbolt: Add support for preboot ACL")
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> > Changes from v1 (https://lkml.org/lkml/2018/4/27/845):
> 
> >   * Use || instead of && to make sure UUIDs with only one zero DW
> >     are still treated as valid.
> 
> >   drivers/thunderbolt/icm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> > diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> > index 2d2ceda9aa26..500911f16498 100644
> > --- a/drivers/thunderbolt/icm.c
> > +++ b/drivers/thunderbolt/icm.c
> > @@ -1255,7 +1255,7 @@ static int icm_ar_get_boot_acl(struct tb *tb,
> uuid_t *uuids, size_t nuuids)
> >                          /* Map empty entries to null UUID */
> >                          uuid[0] = 0;
> >                          uuid[1] = 0;
> > -               } else {
> > +               } else if (uuid[0] != 0 || uuid[1] != 0) {
> >                          /* Upper two DWs are always one's */
> >                          uuid[2] = 0xffffffff;
> >                          uuid[3] = 0xffffffff;
> > --
> > 2.17.0
> 
> 
> Acked-by: Yehezkel Bernat <yehezkelshb@gmail.com>

Applied to thunderbolt.git/fixes.
