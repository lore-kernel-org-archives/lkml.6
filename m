Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE480C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594AB2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594AB2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbeJKFzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:55:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45098 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKFzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 01:55:16 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 23287D3A;
        Wed, 10 Oct 2018 22:31:03 +0000 (UTC)
Date:   Wed, 10 Oct 2018 15:31:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/6] tools/gup_benchmark: Allow user specified file
Message-Id: <20181010153101.4f5dcf6dcc01e71934eeb1ba@linux-foundation.org>
In-Reply-To: <20181010195605.10689-4-keith.busch@intel.com>
References: <20181010195605.10689-1-keith.busch@intel.com>
        <20181010195605.10689-4-keith.busch@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2018 13:56:03 -0600 Keith Busch <keith.busch@intel.com> wrote:

> This patch allows a user to specify a file to map by adding a new option,
> '-f', providing a means to test various file backings.
> 
> If not specified, the benchmark will use a private mapping of /dev/zero,
> which produces an anonymous mapping as before.
> 
> ...
>
> --- a/tools/testing/selftests/vm/gup_benchmark.c
> +++ b/tools/testing/selftests/vm/gup_benchmark.c
>
> ...
>
> @@ -61,11 +62,18 @@ int main(int argc, char **argv)
>  		case 'w':
>  			write = 1;
>  			break;
> +		case 'f':
> +			file = optarg;
> +			break;
>  		default:
>  			return -1;
>  		}
>  	}
>  
> +	filed = open(file, O_RDWR|O_CREAT);
> +	if (filed < 0)
> +		perror("open"), exit(filed);

Ick.  Like this, please:

--- a/tools/testing/selftests/vm/gup_benchmark.c~tools-gup_benchmark-allow-user-specified-file-fix
+++ a/tools/testing/selftests/vm/gup_benchmark.c
@@ -71,8 +71,10 @@ int main(int argc, char **argv)
 	}
 
 	filed = open(file, O_RDWR|O_CREAT);
-	if (filed < 0)
-		perror("open"), exit(filed);
+	if (filed < 0) {
+		perror("open");
+		exit(filed);
+	}
 
 	gup.nr_pages_per_call = nr_pages;
 	gup.flags = write;

