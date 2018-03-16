Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932820AbeCPDL7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 23:11:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932548AbeCPDLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 23:11:55 -0400
Date: Thu, 15 Mar 2018 22:11:54 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Laura Abbott <labbott@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New -Werror=restrict error with incremental gcc
Message-ID: <20180316031154.juk2uncs7baffctp@treble>
References: <34478c69-e238-90db-bf1e-9622a060c778@redhat.com>
 <20180315143012.GA2221@redhat.com>
 <53714ddf-1b2d-295b-e364-3330f1d9c48c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53714ddf-1b2d-295b-e364-3330f1d9c48c@redhat.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 08:06:26AM -0700, Laura Abbott wrote:
> This only showed up with the very latest rawhide snapshot, .17 worked and
> .18 started failing. I had to download .18 manually to test locally
> https://koji.fedoraproject.org/koji/packageinfo?packageID=40

I also see the error with the latest gcc master branch.  The code is
harmless, but maybe the warning is useful in other places, so here's one
way to fix it.

----

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] objtool, perf: Fix GCC 8 -Wrestrict error

Starting with recent GCC 8 builds, objtool and perf fail to build with
the following error:

  ../str_error_r.c: In function ‘str_error_r’:
  ../str_error_r.c:25:3: error: passing argument 1 to restrict-qualified parameter aliases with argument 5 [-Werror=restrict]
     snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);

The code seems harmless, but there's probably no benefit in printing the
'buf' pointer in this situation anyway, so just remove it to make GCC
happy.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/lib/str_error_r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/str_error_r.c b/tools/lib/str_error_r.c
index d6d65537b0d9..6aad8308a0ac 100644
--- a/tools/lib/str_error_r.c
+++ b/tools/lib/str_error_r.c
@@ -22,6 +22,6 @@ char *str_error_r(int errnum, char *buf, size_t buflen)
 {
 	int err = strerror_r(errnum, buf, buflen);
 	if (err)
-		snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
+		snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, [buf], %zd)=%d", errnum, buflen, err);
 	return buf;
 }
-- 
2.14.3
