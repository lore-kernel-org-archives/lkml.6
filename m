Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAEFC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858F320652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YmTupfTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858F320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeJVSr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:47:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57058 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeJVSr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:47:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MANgJK097602;
        Mon, 22 Oct 2018 10:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=WYiFHO05oFRZx7Uwgb8OEXnSI45jD9jUBA6q1zD7taU=;
 b=YmTupfTCSnUBBUkgueI4VlF8KbCzWt9wYp4hZbxmCT7PK/kXA4jHg2FpLMoLXpHoymFq
 4PtAxvxiVoUjAKgeIwVH8+ZLi7x8TCv73AURWSaYhgrHfzbnN8R6D3MjTCyciEFIQED2
 iTfZ7rvqQPHyVg6CJAAIiWL7bI9/geq6/Ncm087TRaK6qS9cf3cLi397sVkNsNt+tzdn
 7LjTYwSeYNquEP6PDXQ0jjclvqvFp/jg741vltZ1YST1WKJDgRQVny/zA/3kTcbc9vI9
 62WRTCSHRqENtSUmyipuaRzK6Gg7q5b3sO09joSTfP81xg99UcWm1IrsVqCLpsxCYSNL mg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2n7ustwmue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 10:28:15 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9MASFg1013826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 10:28:15 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9MAS4R8001605;
        Mon, 22 Oct 2018 10:28:06 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 03:28:03 -0700
Date:   Mon, 22 Oct 2018 13:27:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 1/2] Compiler Attributes: add support for __fallthrough
 (gcc >= 7.1)
Message-ID: <20181022102743.nua5fgbscyeymzal@mwanda>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
 <20181021171414.22674-2-miguel.ojeda.sandonis@gmail.com>
 <20181021222712.GI1617@thunk.org>
 <8fb78062-b6d4-6f2d-d943-44bec6b95ff0@petrovitsch.priv.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fb78062-b6d4-6f2d-d943-44bec6b95ff0@petrovitsch.priv.at>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9053 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 11:41:56AM +0200, Bernd Petrovitsch wrote:
> On 22/10/2018 00:27, Theodore Y. Ts'o wrote:
> > On Sun, Oct 21, 2018 at 07:14:13PM +0200, Miguel Ojeda wrote:
> >> From the GCC manual:
> >>
> >>   fallthrough
> >>
> >>     The fallthrough attribute with a null statement serves as a
> >>     fallthrough statement. It hints to the compiler that a statement
> >>     that falls through to another case label, or user-defined label
> >>     in a switch statement is intentional and thus the -Wimplicit-fallthrough
> >>     warning must not trigger. The fallthrough attribute may appear
> >>     at most once in each attribute list, and may not be mixed with
> >>     other attributes. It can only be used in a switch statement
> >>     (the compiler will issue an error otherwise), after a preceding
> >>     statement and before a logically succeeding case label,
> >>     or user-defined label.
> >>
> >>   https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html
> > 
> > Do we know if coverity understands the fallthrough attribute?  One of
> > the reasons why I started using /* fallthrough */ is because it kept
> > Coverity happy.
> 
> FWIW, current "eclipse" has the same "problem".
> 
> > If the conversion from /* fallthrough */ to the __fallthrough__
> > attribute means that we start gethting a lot of Coverity warnings,
> 
> We could keep both.

What does that even mean?  Use both the attribute and the comment until
Eclipse is updated?

	case 3:
		frob();
		__fall_through; /* fall through */
	case 4:

That seems like a wrong idea...

regards,
dan carpenter
