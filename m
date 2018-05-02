Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeEBWdF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 18:33:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50892 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeEBWdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 18:33:00 -0400
Date: Wed, 2 May 2018 15:32:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chengguang Xu <cgxu519@gmx.com>
Cc: ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [V9fs-developer] [PATCH v2 1/2] net/9p: detecting invalid
 options as much as possible
Message-Id: <20180502153258.39b65209a0a85063441c6d85@linux-foundation.org>
In-Reply-To: <1523947502-6103-1-git-send-email-cgxu519@gmx.com>
References: <1523947502-6103-1-git-send-email-cgxu519@gmx.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 14:45:01 +0800 Chengguang Xu <cgxu519@gmx.com> wrote:

> Currently when detecting invalid options in option parsing,
> some options(e.g. msize) just set errno and allow to continuously
> validate other options so that it can detect invalid options
> as much as possible and give proper error messages together.
> 
> This patch applies same rule to option 'trans' and 'version'
> when detecting EINVAL.
> 
> ...

A few issues:

> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -199,7 +199,7 @@ static int parse_opts(char *opts, struct p9_client *clnt)
>  					s);
>  				ret = -EINVAL;
>  				kfree(s);
> -				goto free_and_return;
> +				continue;
>  			}
>  			kfree(s);
>  			break;

Here we can just do

--- a/net/9p/client.c~net-9p-detecting-invalid-options-as-much-as-possible-fix
+++ a/net/9p/client.c
@@ -198,8 +198,6 @@ static int parse_opts(char *opts, struct
 				pr_info("Could not find request transport: %s\n",
 					s);
 				ret = -EINVAL;
-				kfree(s);
-				continue;
 			}
 			kfree(s);
 			break;

> @@ -217,7 +217,7 @@ static int parse_opts(char *opts, struct p9_client *clnt)
>  			ret = get_protocol_version(s);

And here's the patch introduces a bug: if `ret' has value -EINVAL from
an earlier parsing error, this code will overwrite that error code with
zero.

So you'll need to introduce a new temporary variable here.  And I
suggest that for future-safety, we permit all error returns from
get_protocol_version(), not just -EINVAL.  So something like:

--- a/net/9p/client.c~net-9p-detecting-invalid-options-as-much-as-possible-fix
+++ a/net/9p/client.c
@@ -214,13 +214,12 @@ static int parse_opts(char *opts, struct
 					 "problem allocating copy of version arg\n");
 				goto free_and_return;
 			}
-			ret = get_protocol_version(s);
-			if (ret == -EINVAL) {
-				kfree(s);
-				continue;
-			}
+			pv = get_protocol_version(s);
+			if (pv >= 0)
+				clnt->proto_version = pv;
+			else
+				ret = pv;
 			kfree(s);
-			clnt->proto_version = ret;
 			break;
 		default:
 			continue;
_


Similar changes can be made to patch 2/2.
