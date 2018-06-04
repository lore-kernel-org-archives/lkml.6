Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeFDCQi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 22:16:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:46984 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751373AbeFDCQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 22:16:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,473,1520924400";
   d="scan'208";a="56257134"
Date: Mon, 4 Jun 2018 10:06:15 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: NeilBrown <neilb@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, changbin.du@intel.com,
        akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] scripts/faddr2line: show the code context
Message-ID: <20180604020614.ov3yeijsiciejyvp@intel.com>
References: <1521444205-2259-1-git-send-email-changbin.du@intel.com>
 <20180529160332.GD12258@hirez.programming.kicks-ass.net>
 <20180529162636.GW12235@hirez.programming.kicks-ass.net>
 <20180529170710.q33dcw5l7a4bwd4t@treble>
 <20180529172430.GB12180@hirez.programming.kicks-ass.net>
 <87sh6aunn7.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sh6aunn7.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20180323-6-5ca392
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 08:01:48AM +1000, NeilBrown wrote:
> On Tue, May 29 2018, Peter Zijlstra wrote:
> 
> > On Tue, May 29, 2018 at 12:07:10PM -0500, Josh Poimboeuf wrote:
> >> Yeah, this change really should have been an optional arg.  It hurt the
> >> readability and compactness of the output.  The above looks good to me.
> >> 
> >> Care to send a proper patch?  If you send it to Linus he might apply it
> >> directly as he did with my original patches.
> >
> > ---
> > From: Peter Zijlstra (Intel) <peterz@infraded.org>
> >
> > Commit 6870c0165feaa5 ("scripts/faddr2line: show the code context")
> > radically altered the output format of the faddr2line tool. And while
> > the new list output format might have merrit it broke my vim usage and
> > was hard to read.
> >
> > Make the new format optional; using a '--list' argument and attempt to
> > make the output slightly easier to read by adding a little whitespace to
> > separate the different files and explicitly mark the line in question.
> 
> Not commenting on your code but on the original patch.....
> I've recently noticed that ADDR2LINE sometimes outputs
>   (discriminator 2)
> or similar at the end of the line.  This messes up the parsing.
> 
> I hacked it to work so I could keep debugging with
> 
> -		local file_lines=$(${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;")
> +		local file_lines=$(${ADDR2LINE} -fpie $objfile $addr | sed -e "s; $dir_prefix\(\./\)*; ;" -e "s/(discriminator [0-9]*)//")
> 
> but someone should probably find out exactly what sort of messages
> ADDR2LINE produces, and make sure they are all parsed correctly.
> (maybe that someone should be me, but not today).
> 
Hi, I have fixed it by commit 78eb0c6356 ("scripts/faddr2line: fix error when
addr2line output contains discriminator") and it is already in the mainline now.
Thank you!

> Thanks,
> NeilBrown
> 
> 
> >
> > Cc: Changbin Du <changbin.du@intel.com>
> > Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Fixes: 6870c0165feaa5 ("scripts/faddr2line: show the code context")
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  scripts/faddr2line | 18 ++++++++++++++++--
> >  1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/faddr2line b/scripts/faddr2line
> > index 1876a741087c..a0149db00be7 100755
> > --- a/scripts/faddr2line
> > +++ b/scripts/faddr2line
> > @@ -56,7 +56,7 @@ command -v ${SIZE} >/dev/null 2>&1 || die "size isn't installed"
> >  command -v ${NM} >/dev/null 2>&1 || die "nm isn't installed"
> >  
> >  usage() {
> > -	echo "usage: faddr2line <object file> <func+offset> <func+offset>..." >&2
> > +	echo "usage: faddr2line [--list] <object file> <func+offset> <func+offset>..." >&2
> >  	exit 1
> >  }
> >  
> > @@ -166,15 +166,25 @@ __faddr2line() {
> >  		local file_lines=$(${ADDR2LINE} -fpie $objfile $addr | sed "s; $dir_prefix\(\./\)*; ;")
> >  		[[ -z $file_lines ]] && return
> >  
> > +		if [[ $LIST = 0 ]]; then
> > +			echo "$file_lines" | while read -r line
> > +			do
> > +				echo $line
> > +			done
> > +			DONE=1;
> > +			return
> > +		fi
> > +
> >  		# show each line with context
> >  		echo "$file_lines" | while read -r line
> >  		do
> > +			echo
> >  			echo $line
> >  			n=$(echo $line | sed 's/.*:\([0-9]\+\).*/\1/g')
> >  			n1=$[$n-5]
> >  			n2=$[$n+5]
> >  			f=$(echo $line | sed 's/.*at \(.\+\):.*/\1/g')
> > -			awk 'NR>=strtonum("'$n1'") && NR<=strtonum("'$n2'") {printf("%d\t%s\n", NR, $0)}' $f
> > +			awk 'NR>=strtonum("'$n1'") && NR<=strtonum("'$n2'") { if (NR=='$n') printf(">%d<", NR); else printf(" %d ", NR); printf("\t%s\n", $0)}' $f
> >  		done
> >  
> >  		DONE=1
> > @@ -185,6 +195,10 @@ __faddr2line() {
> >  [[ $# -lt 2 ]] && usage
> >  
> >  objfile=$1
> > +
> > +LIST=0
> > +[[ "$objfile" == "--list" ]] && LIST=1 && shift && objfile=$1
> > +
> >  [[ ! -f $objfile ]] && die "can't find objfile $objfile"
> >  shift
> >  



-- 
Thanks,
Changbin Du
