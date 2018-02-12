Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AH8x224XUghTin525g1Yo7bUD/QnnImM4XA9Ev5tEA+4je0iXQAV5fA9PBb0oxzWCrqINNeQc6Yc
ARC-Seal: i=1; a=rsa-sha256; t=1518421610; cv=none;
        d=google.com; s=arc-20160816;
        b=AcCavlHQ4G4crwqk4JMxQXnXfKmC6VfFzqPlh67jDI+TNr8M6FK9UexnMpdrHzBWS0
         rY3NcyDVaMXbWXPMhMlCl4fymSQAJqyqc91EFrZyPqUA0Uh89uuPX2uE1Ud+bLda/r1Y
         OoZqQbj4hQk0WNkRq3ax2dSf1VkgizQsMJwwgntijcgHST0i37zmwD0TGugqP6SezyNJ
         OO1pLq+b/ucMDtC0VyAM9IwsJSaPpBuskTUIusAvq0HlpCP2c7ScuED4HCJtYzzwCin9
         qK7aVpKdvMqsSbu6fBAXFVx1sI/nDIY8fUjhfsPnotnRYZypho4HYy66mlVfpPgArV7k
         Fdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ebpeR5yk3oCjd7REgyHfAw3O56b3ApcyZQauI1VZ+J4=;
        b=qdxi6ivCiG05eUXuPgjWRE9dNn/O+1sKQs5AhalCJjcnCs/YaqTo76ooMZKkOzjjN2
         ssueoJ2Qa18RqxQxthUuwUMq3oELPS5gRyPl48zxyauEpv6uTGv9xYQztcl65RLhF36Z
         ISZubtIvCSF3ba+A1gc+A6WyKjzQhYE0Aw7a3TdyLHN36gm1LjHCA8XvePaxKi7UzB51
         ehDwquc7tVMq3GwM3/lb3Ikvau+O82CHrMaxXt7V30ezSdB2zdLsDn6G72wRwM60MHA+
         LbWCBtdtkFqrVQxQlBGcnlfNbJu4KYVBi2iv+i4lZlTFRF+EQ204hKuVXWE8AGwKYVAQ
         rA6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=JS1b1FDj;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=JS1b1FDj;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Mon, 12 Feb 2018 10:41:07 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: NeilBrown <neilb@suse.com>
Cc: James Simmons <jsimmons@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>, wang di <di.wang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 41/80] staging: lustre: lmv: separate master object with
 master stripe
Message-ID: <20180212074107.ulp52nikjv5m5mf2@mwanda>
References: <1471378773-24590-1-git-send-email-jsimmons@infradead.org>
 <1471378773-24590-42-git-send-email-jsimmons@infradead.org>
 <87r2pvkkl5.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2pvkkl5.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120101
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1542852481688536081?=
X-GMAIL-MSGID: =?utf-8?q?1592180458177963273?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 12:39:18PM +1100, NeilBrown wrote:
> On Tue, Aug 16 2016, James Simmons wrote:
> 
> >  
> > +static inline bool
> > +lsm_md_eq(const struct lmv_stripe_md *lsm1, const struct lmv_stripe_md *lsm2)
> > +{
> > +	int idx;
> > +
> > +	if (lsm1->lsm_md_magic != lsm2->lsm_md_magic ||
> > +	    lsm1->lsm_md_stripe_count != lsm2->lsm_md_stripe_count ||
> > +	    lsm1->lsm_md_master_mdt_index != lsm2->lsm_md_master_mdt_index ||
> > +	    lsm1->lsm_md_hash_type != lsm2->lsm_md_hash_type ||
> > +	    lsm1->lsm_md_layout_version != lsm2->lsm_md_layout_version ||
> > +	    !strcmp(lsm1->lsm_md_pool_name, lsm2->lsm_md_pool_name))
> > +		return false;
> 
> Hi James and all,
>  This patch (8f18c8a48b736c2f in linux) is different from the
>  corresponding patch in lustre-release (60e07b972114df).
> 
> In that patch, the last clause in the 'if' condition is
> 
> +           strcmp(lsm1->lsm_md_pool_name,
> +                     lsm2->lsm_md_pool_name) != 0)
> 
> Whoever converted it to "!strcmp()" inverted the condition.  This is a
> perfect example of why I absolutely *loathe* the "!strcmp()" construct!!

People think that "if (!strcmp()) " is prefered kernel style but it's
not.

	if (foo != NULL) {

The != NULL is a double negative.  I don't think it adds anything.
Some kernel developers like this style because it's explicit about the
type.  I have never seen any bugs caused by this format or solved by
this format.  Anyway checkpatch complains.

	if (ret != 0) {

In this situation "ret" is not a number, it's an error code.  The != 0
is a double negative and complicated to think about.  Btw, I sort of
prefer "if (ret)" to "if (ret < 0)", not because of style but it's
easier for Smatch.  No subsystems are totally consistent so the (by
definition inconsistent) "if (ret < 0)" checks cause false positives in
Smatch.

	if (len != 0)

This is OK.  "len" is a number.

	if (strcmp(one, two) != 0) {

With strcmp() I really prefer == 0 and != 0 because it works like this:

	strcmp(one, two) == 0  --> means one == two
	strcmp(one, two) < 0   --> means one < two
        strcmp(one, two) != 0  --> means one != two

Either style is accepted in the kernel but I think == 0 just makes so
much sense.  I mostly see bugs from this when people are "fixing" the
style from == 0 to !strcmp() so my sample is very biased.  Normally, if
the original author writes the code any bugs are caught in testing so
either way is going to be bug free.

But the only thing that checkpatch complains about is == NULL and
!= NULL.

regards,
dan carpenter
