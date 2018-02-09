Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeBIJrT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:47:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:7523 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751299AbeBIJrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:47:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,482,1511856000";
   d="scan'208";a="29440709"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mchehab@kernel.org, me@tobin.cc,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 8/8] docs: kernel-doc: Don't mangle literal code blocks in comments
In-Reply-To: <20180207172624.24555-9-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180207172624.24555-1-corbet@lwn.net> <20180207172624.24555-9-corbet@lwn.net>
Date: Fri, 09 Feb 2018 11:47:08 +0200
Message-ID: <87y3k28pgj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Feb 2018, Jonathan Corbet <corbet@lwn.net> wrote:
> It can be useful to put code snippets into kerneldoc comments; that can be
> done with the "::" operator at the end of a line like this::
>
>    if (desperate)
>        run_in_circles();
>
> kernel-doc currently fails to understand these literal blocks and applies
> its normal markup to them, which is then treated as literal by sphinx.  The
> result is unsightly markup instead of a useful code snippet.
>
> Apply a hack to the output code to recognize literal blocks and avoid
> performing any special markup on them.  It's ugly, but that means it fits
> in well with the rest of the script.
>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/kernel-doc | 55 +++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index c6c9370a1e49..c984f82cb897 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -748,14 +748,59 @@ sub output_blockhead_rst(%) {
>      }
>  }
>  
> -sub output_highlight_rst {
> -    my $contents = join "\n",@_;
> -    my $line;
> -
> +#
> +# Apply the RST highlights to a sub-block of text.
> +#   
> +sub highlight_block($) {
> +    # The dohighlight kludge requires the text be called $contents
> +    my $contents = shift;
>      eval $dohighlight;
>      die $@ if $@;
> +    return $contents;
> +}
>  
> -    foreach $line (split "\n", $contents) {
> +sub output_highlight_rst {
> +    my $input = join "\n",@_;
> +    my $output = "";
> +    my $line;
> +    my $in_literal = 0;
> +    my $litprefix;
> +    my $block = "";
> +
> +    # The "dohighlight" hack requires that the data be called "$contents"
> +    foreach $line (split "\n",$input) {
> +	#
> +	# If we're in a literal block, see if we should drop out
> +	# of it.  Otherwise pass the line straight through unmunged.
> +	#
> +	if ($in_literal) {
> +	    if (! ($line =~ /$litprefix/ || $line =~ /^\s*$/)) {
> +		$in_literal = 0;
> +	    }
> +	    else {
> +		$output .= $line . "\n";
> +	    }
> +	}
> +	#
> +	# Not in a literal block (or just dropped out)
> +	#
> +	if (! $in_literal) {
> +	    $block .= $line . "\n";
> +	    if ($line =~ /^[^.].*::$/) {

I think you should also add "code-block:: <language>" to the
regexp. There are only a few uses now, but I think someone's bound to
hit the same problem with those.

Perhaps also extract the regexp to a variable with a self-documenting
name.

Thanks for doing this. Not that I like it, but as you say, it fits right
in the script. I have some ideas on how to do all of the highlights
nicely as post-processing in the Sphinx extension, but we need this now
and not somewhere in the distant future.

BR,
Jani.

> +		$in_literal = 1;
> +		# Note current indentation - we'll go as long as it's deeper.
> +		$line =~ /^(\s*)/;
> +		$litprefix = '^' . $1 . ' ';
> +		$output .= highlight_block($block);
> +		$block = ""
> +	    }
> +	}
> +    }
> +
> +    if ($block) {
> +	$output .= highlight_block($block);
> +    }
> +    foreach $line (split "\n", $output) {
>  	print $lineprefix . $line . "\n";
>      }
>  }

-- 
Jani Nikula, Intel Open Source Technology Center
