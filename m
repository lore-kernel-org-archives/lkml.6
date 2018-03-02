Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428760AbeCBOvB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:51:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426414AbeCBOu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:50:58 -0500
Date: Fri, 2 Mar 2018 06:50:55 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Jani Nikula <jani.nikula@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/sphinx: Fix Directive import error
Message-ID: <20180302145055.GA18137@bombadil.infradead.org>
References: <s5hbmg6hf4g.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hbmg6hf4g.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 12:49:03PM +0100, Takashi Iwai wrote:
> I'm no expert of sphinx nor python, so something might be wrong.
> Please check it.

I'm also not a pythonista, but ...

> --- a/Documentation/sphinx/kerneldoc.py
> +++ b/Documentation/sphinx/kerneldoc.py
> @@ -37,7 +37,10 @@ import glob
>  from docutils import nodes, statemachine
>  from docutils.statemachine import ViewList
>  from docutils.parsers.rst import directives
> -from sphinx.util.compat import Directive
> +try:
> +    from sphinx.util.compat import Directive
> +except ImportError:
> +    from docutils.parsers.rst import directives, Directive

It seems to me the previous line already imported
docutils.parsers.rst.directives, and we should probably prefer the newer
parser even with Sphinx 1.6, so I would think this would work better:

-from sphinx.util.compat import Directive
+try:
+    from docutils.parsers.rst import Directive
+except ImportError:
+    from sphinx.util.compat import Directive

(it works on Debian with Sphinx 1.6.7)
