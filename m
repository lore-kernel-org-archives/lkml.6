Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932607AbeDWWlL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 18:41:11 -0400
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:49388 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932514AbeDWWlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 18:41:10 -0400
Date: Mon, 23 Apr 2018 17:41:06 -0500 (CDT)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Vlastimil Babka <vbabka@suse.cz>
cc: Michal Hocko <mhocko@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        dm-devel@redhat.com, David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLUB: Do not fallback to mininum order if __GFP_NORETRY
 is set
In-Reply-To: <26580de4-70b5-90f7-b3b9-22f57ba38843@suse.cz>
Message-ID: <alpine.DEB.2.20.1804231738020.3811@nuc-kabylake>
References: <alpine.DEB.2.20.1804180944180.1062@nuc-kabylake> <20180419110051.GB16083@dhcp22.suse.cz> <alpine.DEB.2.20.1804200952230.18006@nuc-kabylake> <26580de4-70b5-90f7-b3b9-22f57ba38843@suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfEcjkcIxzJKVPhWLxpQ2X8DhEQ2pJNDLla7KQesvz0T3n3MzC+1sPzmYvYqssex3H0zdicditeCpMMauUiakGsETr2KH7ewJUW0iS54yKsyd7BeQYbmS
 arTi9s+kqGj3QywZlQlhSxr7xR729DDHjsSHo6wv/HtYgwbbqNEGmXiAX47+Tdy2cE8yoStynnPRmUMZs8mjurxx2fmkoVN162tG5VTvY+VZVw/pTKL5WcQz
 Qh/JC5D8gRrC/EB4xo7iWIfVfTBmeQR47kz1AXejCrN4wn7dxqp+n9+3RJCW73pCVvo1+BOxEiyWOHAqkERQYJWBGlF7t8TcOkkmvHNxD5u/3DqsPQdk8Xiu
 yQ2dGc40tbNV9QUtZBEj3bcKMISNd+jdVev8dqcXS+pXNHDSM8Uu5N3OYvzTbuP2zXx/P5/vY7PxOgyUK4Zbsi6f9IoGROBm94csvhInEj/PUGzb4CG86AA3
 3OXBOo13N099PC/0zYk+mB3G05LBq5/RxcnqGg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2018, Vlastimil Babka wrote:

> > The problem is that SLUB does not honor GFP_NORETRY. The semantics of
> > GFP_NORETRY are not followed.
>
> The caller might want SLUB to try hard to get that high-order page that
> will minimize memory waste (e.g. 2MB page for 3 640k objects), and
> __GFP_NORETRY will kill the effort on allocating that high-order page.

Well yes since *_NORETRY says that fallbacks are acceptable.

> Thus, using __GPF_NORETRY for "please give me a space-optimized object,
> or nothing (because I have a fallback that's better than wasting memory,
> e.g. by using 1MB page for 640kb object)" is not ideal.
>
> Maybe __GFP_RETRY_MAYFAIL is a better fit? Or perhaps indicate this
> situation to SLUB with e.g. __GFP_COMP, although that's rather ugly?

Yuck. None of that sounds like an intuitive approach.
