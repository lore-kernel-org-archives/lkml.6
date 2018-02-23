Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtvuzx/1ToYZCi0Bxm8yOR1pj6Gf2KvMjN6ikxhKzMCA7OgCG3y7vinh26qBxfxSzGhpp4F
ARC-Seal: i=1; a=rsa-sha256; t=1519411628; cv=none;
        d=google.com; s=arc-20160816;
        b=XFH3W/zr8QPwt8rb7ex9J1nLnbTuCMy1pdKQUkriaHm5qDkE/U5SdHK/EWLhv7UDxz
         AKb92rweE5C8SeQWT3azseQ6LrZ3pvx/t7iIHWROtxh5sLn0CsZ+TAW0qqQG6uo4vmYb
         q4d1pSwJKRmIYKtlVsPdF5yOiNnJgB0jN+GgXSwB5h+pL1SC6y0X5cszxCDlBztmYlKV
         m2ZRoFrS8bF/Bl+8SliTsVddGiYRuZB2g+jdhGLsC135HSl0wPVSvgDqLW63H358EGB0
         kI7VVGeFNEx5luYXt+3oK8wjJci68oNgwkD0y5a18vj7g1etMv6Ok7LgfiiWRP1Eu+rW
         VBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/6QL9qj8TDUO1MyJxoNn87bRclRMnL3RkyGPPFPL2Ks=;
        b=DkrEGRbidYbW9iE2eL27NNnoABcNJm/SS52kWRIYiayIWCrvAi1Y67IC3RWWM3cr1H
         nMJkUUxQzUbAJHzpTVfLtIZpiE8c51XYdypvqo80DUZvvhGqG8DRuL4tYjbGR4xfR304
         PrVlKpnpmnfvA5jZb6uO3s37K4hNNMmQD+42WhDH42kBRaoaDwViLCV6S/j2kSITbdyQ
         ukvjem/ZZfrQJ86GG4rJyaQufDmInC7imUNOEhLA/W42UyYtaKAriXAeliJL/mog3j7E
         X0vOC9LzRNtwEJl47dv315xQggTWoqmUV2H9UugY8f5NuyfA/aDyMseLf5zp27MHatF4
         JlnA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Michal Marek <mmarek@suse.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.9 108/145] tools build: Add tools tree support for make -s
Date: Fri, 23 Feb 2018 19:26:54 +0100
Message-Id: <20180223170738.780387317@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218010959624529?=
X-GMAIL-MSGID: =?utf-8?q?1593218568326026363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit e572d0887137acfc53f18175522964ec19d88175 upstream.

When doing a kernel build with 'make -s', everything is silenced except
the objtool build.  That's because the tools tree support for silent
builds is some combination of missing and broken.

Three changes are needed to fix it:

- Makefile: propagate '-s' to the sub-make's MAKEFLAGS variable so the
  tools Makefiles can see it.

- tools/scripts/Makefile.include: fix the tools Makefiles' ability to
  recognize '-s'.  The MAKE_VERSION and MAKEFLAGS checks are copied from
  the top-level Makefile.  This silences the "DESCEND objtool" message.

- tools/build/Makefile.build: add support to the tools Build files for
  recognizing '-s'.  Again the MAKE_VERSION and MAKEFLAGS checks are
  copied from the top-level Makefile.  This silences all the object
  compile/link messages.

Reported-and-Tested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michal Marek <mmarek@suse.com>
Link: http://lkml.kernel.org/r/e8967562ef640c3ae9a76da4ae0f4e47df737c34.1484799200.git.jpoimboe@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Makefile                       |    6 ++++--
 tools/build/Makefile.build     |   10 ++++++++++
 tools/scripts/Makefile.include |   12 +++++++++++-
 3 files changed, 25 insertions(+), 3 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -87,10 +87,12 @@ endif
 ifneq ($(filter 4.%,$(MAKE_VERSION)),)	# make-4
 ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
   quiet=silent_
+  tools_silent=s
 endif
 else					# make-3.8x
 ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
   quiet=silent_
+  tools_silent=-s
 endif
 endif
 
@@ -1614,11 +1616,11 @@ image_name:
 # Clear a bunch of variables before executing the submake
 tools/: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter --j% -j,$(MAKEFLAGS))" O=$(shell cd $(objtree) && /bin/pwd) subdir=tools -C $(src)/tools/
+	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(shell cd $(objtree) && /bin/pwd) subdir=tools -C $(src)/tools/
 
 tools/%: FORCE
 	$(Q)mkdir -p $(objtree)/tools
-	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter --j% -j,$(MAKEFLAGS))" O=$(shell cd $(objtree) && /bin/pwd) subdir=tools -C $(src)/tools/ $*
+	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(shell cd $(objtree) && /bin/pwd) subdir=tools -C $(src)/tools/ $*
 
 # Single targets
 # ---------------------------------------------------------------------------
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -19,6 +19,16 @@ else
   Q=@
 endif
 
+ifneq ($(filter 4.%,$(MAKE_VERSION)),)	# make-4
+ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
+  quiet=silent_
+endif
+else					# make-3.8x
+ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
+  quiet=silent_
+endif
+endif
+
 build-dir := $(srctree)/tools/build
 
 # Define $(fixdep) for dep-cmd function
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -46,6 +46,16 @@ else
 NO_SUBDIR = :
 endif
 
+ifneq ($(filter 4.%,$(MAKE_VERSION)),)  # make-4
+ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
+  silent=1
+endif
+else					# make-3.8x
+ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
+  silent=1
+endif
+endif
+
 #
 # Define a callable command for descending to a new directory
 #
@@ -58,7 +68,7 @@ descend = \
 QUIET_SUBDIR0  = +$(MAKE) $(COMMAND_O) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
-ifneq ($(findstring $(MAKEFLAGS),s),s)
+ifneq ($(silent),1)
   ifneq ($(V),1)
 	QUIET_CC       = @echo '  CC       '$@;
 	QUIET_CC_FPIC  = @echo '  CC FPIC  '$@;
