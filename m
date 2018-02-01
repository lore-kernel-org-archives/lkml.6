Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbeBAPnT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:43:19 -0500
Received: from mx0a-00191d01.pphosted.com ([67.231.149.140]:44676 "EHLO
        mx0a-00191d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751547AbeBAPnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:43:16 -0500
From: "Brown, Nicholas" <nb930b@intl.att.com>
To: "joe@perches.com" <joe@perches.com>,
        "apw@canonical.com" <apw@canonical.com>, "me@tobin.cc" <me@tobin.cc>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: warn if changed lines exceeds a maximum size
Thread-Topic: [PATCH] checkpatch: warn if changed lines exceeds a maximum
 size
Thread-Index: AQHTmeMGAPsYZkfslkm5Wnly+K55WaOMldQAgAAf4ICAAA/2gIAAAlYAgAAVDACAAACEgIACgE0AgAAmAICAAC7oAA==
Date: Thu, 1 Feb 2018 15:42:35 +0000
Message-ID: <1517499752.3668.10.camel@intl.att.com>
References: <1517343904.3063.33.camel@intl.att.com>
         <20180130202655.22990-1-nick.brown@att.com>
         <1517481518.3063.92.camel@intl.att.com>
         <1517489679.7489.31.camel@perches.com>
In-Reply-To: <1517489679.7489.31.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.156.48.128]
Content-Type: text/plain; charset="utf-8"
Content-ID: <81565E0D25956A499F5A0F4D44E76104@intl.att.com>
MIME-Version: 1.0
X-RSA-Inspected: yes
X-RSA-Classifications: public
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802010201
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w11FhQg2032362

On Thu, 2018-02-01 at 04:54 -0800, Joe Perches wrote:
> On Thu, 2018-02-01 at 10:38 +0000, Brown, Nicholas wrote:
> > Hi,
> > 
> > Would one of you be happy to pick this patch up for carrying into
> > the next release?
> 
> Not me.
> 
> I think the metric is too simplistic and
> not particularly useful.

I'm not sure it's any more simplistic than than the character line
length limit, which is there to prompt thought on code nesting levels,
etc. And as it has to be explicitly configured it allows developers the
discretion to determine a code change size that meaningful in a given
situation.

> 
> If others want it, I think you should
> try to build or find a bit more agreement
> from the many other linux developers that
> this change is actually desired by them.

It's been used as a heuristic as part of code reviews within our
development team, with differing sizes depending on the maintainer, and
I though it might be similarly useful wide community.

One use case was:

IGNORE_TYPES="FILE_PATH_CHANGES,LINE_SPACING,GIT_COMMIT_ID,SPLIT_STRING,PREFER_PRINTF"
checkpatch.pl \
    --no-tree --no-signoff --show-types --emacs \
    --max-changed-lines=500 \
    --ignore "$IGNORE_TYPES" \
    --git  "$(git merge-base "$SOURCE" "$TARGET")".."$SOURCE"

Thanks,
Nick

> 
> > Thanks,
> > Nick
> 
> cheers, Joe
> 
> > 
> > On Tue, 2018-01-30 at 20:26 +0000, Nicholas Brown wrote:
> > > Changed lines is the total of inserted and deleted lines.
> > > By default there is no limit, --max-changed-lines may be used to
> > > set a
> > > value. Some users may wish to encourage that patches are split
> > > into
> > > smaller parts using this.
> > > See Documentation/process/submitting-patches.rst#split-changes
> > > 
> > > Signed-off-by: Nicholas Brown <nick.brown@att.com>
> > > ---
> > >  scripts/checkpatch.pl | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 31031f10fe56..a71bc4f15ce7 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -49,6 +49,7 @@ my @ignore = ();
> > >  my $help = 0;
> > >  my $configuration_file = ".checkpatch.conf";
> > >  my $max_line_length = 80;
> > > +my $max_changed_lines; # undef = no max
> > >  my $ignore_perl_version = 0;
> > >  my $minimum_perl_version = 5.10.0;
> > >  my $min_conf_desc_length = 4;
> > > @@ -92,6 +93,8 @@ Options:
> > >    --ignore TYPE(,TYPE2...)   ignore various comma separated
> > > message types
> > >    --show-types               show the specific message type in
> > > the output
> > >    --max-line-length=n        set the maximum line length, if
> > > exceeded, warn
> > > +  --max-changed-lines=n      set the maximum number of changed
> > > lines allowed,
> > > +                             if exceeded, warn. (insertions +
> > > deletions)
> > >    --min-conf-desc-length=n   set the min description length, if
> > > shorter, warn
> > >    --root=PATH                PATH to the kernel tree root
> > >    --no-summary               suppress the per-file summary
> > > @@ -209,6 +212,7 @@ GetOptions(
> > >  	'show-types!'	=> \$show_types,
> > >  	'list-types!'	=> \$list_types,
> > >  	'max-line-length=i' => \$max_line_length,
> > > +	'max-changed-lines=i' => \$max_changed_lines,
> > >  	'min-conf-desc-length=i' => \$min_conf_desc_length,
> > >  	'root=s'	=> \$root,
> > >  	'summary!'	=> \$summary,
> > > @@ -2165,6 +2169,8 @@ sub process {
> > >  	my $filename = shift;
> > >  
> > >  	my $linenr=0;
> > > +	my $inserted_lines_total=0;
> > > +	my $deleted_lines_total=0;
> > >  	my $prevline="";
> > >  	my $prevrawline="";
> > >  	my $stashline="";
> > > @@ -2233,6 +2239,14 @@ sub process {
> > >  
> > >  		push(@fixed, $rawline) if ($fix);
> > >  
> > > +		if ($rawline=~/^\+/ && $rawline!~/^\+\+\+/) {
> > > +			$inserted_lines_total++
> > > +		}
> > > +
> > > +		if ($rawline=~/^-/ && $rawline!~/^---/) {
> > > +			$deleted_lines_total++;
> > > +		}
> > > +
> > >  		if ($rawline=~/^\+\+\+\s+(\S+)/) {
> > >  			$setup_docs = 0;
> > >  			if ($1 =~ m@Documentation/admin-
> > > guide/kernel-parameters.rst$@) {
> > > @@ -2306,6 +2320,13 @@ sub process {
> > >  
> > >  	$prefix = '';
> > >  
> > > +	#print "inserted: $inserted_lines_total\n";
> > > +	#print "deleted: $deleted_lines_total\n";
> 
> Not much utility in the debugging code either.
> 
> > > +	if (defined $max_changed_lines &&
> > > +	    ($inserted_lines_total+$deleted_lines_total >
> > > $max_changed_lines)) {
> > > +		WARN("MAX_CHANGED_LINES", "please split the
> > > change into smaller parts\n");
> > > +	}
> > > +
> > >  	$realcnt = 0;
> > >  	$linenr = 0;
> > >  	$fixlinenr = -1;
