Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750933AbeBIFgg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 00:36:36 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46380 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeBIFgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 00:36:35 -0500
X-Google-Smtp-Source: AH8x225UBRtssI7d20NlErX/ihtWUrMmGon1H1aT9ysU5afcEaOo5ABr+LCp579hZU7Z8wQHAQO6qg==
Date: Fri, 9 Feb 2018 14:36:30 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH 1/2] zsmalloc: introduce zs_huge_object() function
Message-ID: <20180209053630.GC689@jagdpanzerIV>
References: <20180207092919.19696-1-sergey.senozhatsky@gmail.com>
 <20180207092919.19696-2-sergey.senozhatsky@gmail.com>
 <20180208163006.GB17354@rapoport-lnx>
 <20180209025520.GA3423@jagdpanzerIV>
 <20180209041046.GB23828@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209041046.GB23828@bombadil.infradead.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/08/18 20:10), Matthew Wilcox wrote:
[..]
> Examples::
> 
>   * Context: Any context.
>   * Context: Any context. Takes and releases the RCU lock.
>   * Context: Any context. Expects <lock> to be held by caller.
>   * Context: Process context. May sleep if @gfp flags permit.
>   * Context: Process context. Takes and releases <mutex>.
>   * Context: Softirq or process context. Takes and releases <lock>, BH-safe.
>   * Context: Interrupt context.

I assume that  <mutex>  spelling serves as a placeholder and should be
replaced with a lock name in a real comment. E.g.

	Takes and releases audit_cmd_mutex.

or should it actually be

	Takes and releases <audit_cmd_mutex>.




So below is zs_huge_object() documentation I came up with:

---

+/**
+ * zs_huge_object() - Test if a compressed object's size is too big for normal
+ *                    zspool classes and it will be stored in a huge class.
+ * @sz: Size in bytes of the compressed object.
+ *
+ * The functions checks if the object's size falls into huge_class area.
+ * We must take ZS_HANDLE_SIZE into account and test the actual size we
+ * are going to use up, because zs_malloc() unconditionally adds the
+ * handle size before it performs size_class lookup.
+ *
+ * Context: Any context.
+ *
+ * Return:
+ * * true  - The object's size is too big, it will be stored in a huge class.
+ * * false - The object will be store in normal zspool classes.
+ */
---

looks OK?

	-ss
