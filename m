Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AB8JxZo0nAs5BThjHL4s9UItrM+dCcwXxvcP/TEmzAj/GtdoQwV9j1mE7etvBwx5Qst9Xm6suiJv
ARC-Seal: i=1; a=rsa-sha256; t=1524689629; cv=none;
        d=google.com; s=arc-20160816;
        b=W/zCf+TSzc0d1/qh22jwImmVyEEsd7ca4p6mkcGxfqmZTHwD2xHihrKq7LksjLQDIe
         lhr+nMVAm2Eqbdg/xz9P9yzE5vKW7LGZcoU8AMoRcqOWlHaQq7lpfYqsAvwsvqvI/RAk
         geXLK9tHC+BxtYjkC4EATqybgT+pVvdrs/1lYVzByjR6mDDW9l1pfsZgnM+uaLeeV2/v
         0GqOU0uO3iG3pxawcXbyvDzM3UzTeLSETvyitZqY4DcMM20M119EJZ+Ic6tnxWcVPbZS
         lnYZXsFW8KqAYabmVaKmNseHnZFCY68beZ4SeTw9npkn0cr7d6qJF0+3jkPDcJYkR9rl
         HPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:arc-authentication-results;
        bh=xsER2JXUlWUkAhz3Z6ypWCSCdM5OK1AYw5zjNK11TFY=;
        b=F5KKgmzSjsEbBtXNafEBqrcdi2oUbLFZom1cdCcL2EKivIVfofoY8+8N0aUVCd9bQP
         9EyeRwIc15sEiXpaulA68sVoAVk91m34M6IEMRipactQLbUR1IBVSf7hilPKPxg2OMM/
         avxPp64ujLjUR/ruVjUIjm3jimrXv83AxRfoIEaydykeWzijKUhhIsA1vpVtAvw01Pq9
         FFu2XBhBYpvtneXuAwys6Lzk7ZOF+BzEC2RotrqyFmzhWl1AfNUk26WGTEYJy1FhCydl
         4jF6NKTVKP3iYn38UBPH4a4FiPkNd+A+A2TggxoTBzhsWgs8xdKEAkI4Gp7277ajgNgq
         tCUg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180425203703.650160358@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 25 Apr 2018 22:30:27 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Hans Verkuil <hans.verkuil@cisco.com>,
 Mauro Carvalho Chehab <mchehab@s-opensource.com>,
 Christoph Hellwig <hch@lst.de>
Subject: [patch V2 7/7] scripts: Add SPDX checker script
References: <20180425203020.594959448@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=scripts--Add-SPDX-checker-script.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598752952851638430?=
X-GMAIL-MSGID: =?utf-8?q?1598752952851638430?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The SPDX-License-Identifiers are growing in the kernel and so grow
expression failures and license IDs are used which have no corresponding
license text file in the LICENSES directory.

Add a script which gathers information from the LICENSES directory,
i.e. the various tags in the licenses and exception files and then scans
either input from stdin, which it treats as a single file or if started
without arguments it scans the full kernel tree.

It checks whether the license expression syntax is correct and also
validates whether the license identifiers used in the expressions are
available in the LICENSES files.

# scripts/spdxcheck.py -h
usage: spdxcheck.py [-h] [-m MAXLINES] [-s] [-v]

SPDX expression checker

optional arguments:
  -h, --help            show this help message and exit
  -m MAXLINES, --maxlines MAXLINES
                        Maximum number of lines to scan in a file. Default 15
  -s, --stdin           Read from stdin. If not set scan full git tree.
  -v, --verbose         Verbose statistics output


# scripts/spdxcheck.py -s <COPYING

# scripts/spdxcheck.py -s <include/dt-bindings/reset/amlogic,meson-axg-reset.h
include/dt-bindings/reset/amlogic,meson-axg-reset.h: 9:41 Invalid License ID: BSD

# scripts/spdxcheck.py
arch/arm/mach-s3c24xx/h1940-bluetooth.c: 1:28 Invalid License ID: GPL-1.0
arch/x86/kernel/jailhouse.c: 1:28 Invalid License ID: GPL2.0
drivers/pinctrl/sh-pfc/pfc-r8a77965.c: 1:28 Invalid License ID: GPL-2.
include/dt-bindings/reset/amlogic,meson-axg-reset.h: 9:41 Invalid License ID: BSD
arch/x86/include/asm/jailhouse_para.h: 1:28 Invalid License ID: GPL2.0

# time scripts/spdxcheck.py -v
arch/arm/mach-s3c24xx/h1940-bluetooth.c: 1:28 Invalid License ID: GPL-1.0
arch/x86/kernel/jailhouse.c: 1:28 Invalid License ID: GPL2.0
drivers/pinctrl/sh-pfc/pfc-r8a77965.c: 1:28 Invalid License ID: GPL-2.
include/dt-bindings/reset/amlogic,meson-axg-reset.h: 9:41 Invalid License ID: BSD
arch/x86/include/asm/jailhouse_para.h: 1:28 Invalid License ID: GPL2.0

License files:               14
Exception files:              1
License IDs                  19
Exception IDs                 1

Files checked:            61332
Lines checked:           669181
Files with SPDX:          16169
Files with errors:            5

real	0m2.642s
user	0m2.231s
sys	0m0.467s

That's a full tree sweep on my laptop. Note, this runs single threaded.

It scans by default the first 15 lines for a SPDX identifier where the
current max inside a top comment is at line 10. But that's going to be
faster once the identifiers are all in the first two lines as documented.

The python wizards will surely know how to do that smarter and faster, but
its at least better than no tool at all.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 scripts/spdxcheck.py |  260 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 260 insertions(+)

--- /dev/null
+++ b/scripts/spdxcheck.py
@@ -0,0 +1,260 @@
+#!/usr/bin/env python
+# SPDX-License-Identifier: GPL2.0
+# Copyright Thomas Gleixner <tglx@linutronix.de>
+
+from argparse import ArgumentParser
+from ply import lex, yacc
+import traceback
+import sys
+import git
+import re
+import os
+
+class ParserException(Exception):
+    def __init__(self, tok, txt):
+        self.tok = tok
+        self.txt = txt
+
+class SPDXException(Exception):
+    def __init__(self, el, txt):
+        self.el = el
+        self.txt = txt
+
+class SPDXdata(object):
+    def __init__(self):
+        self.license_files = 0
+        self.exception_files = 0
+        self.licenses = [ ]
+        self.exceptions = { }
+
+# Read the spdx data from the LICENSES directory
+def read_spdxdata(repo):
+
+    # The subdirectories of LICENSES in the kernel source
+    license_dirs = [ "preferred", "other", "exceptions" ]
+    lictree = repo.heads.master.commit.tree['LICENSES']
+
+    spdx = SPDXdata()
+
+    for d in license_dirs:
+        for el in lictree[d].traverse():
+            if not os.path.isfile(el.path):
+                continue
+
+            exception = None
+            for l in open(el.path).readlines():
+                if l.startswith('Valid-License-Identifier:'):
+                    lid = l.split(':')[1].strip().upper()
+                    if lid in spdx.licenses:
+                        raise SPDXException(el, 'Duplicate License Identifier: %s' %lid)
+                    else:
+                        spdx.licenses.append(lid)
+
+                elif l.startswith('SPDX-Exception-Identifier:'):
+                    exception = l.split(':')[1].strip().upper()
+                    spdx.exceptions[exception] = []
+
+                elif l.startswith('SPDX-Licenses:'):
+                    for lic in l.split(':')[1].upper().strip().replace(' ', '').replace('\t', '').split(','):
+                        if not lic in spdx.licenses:
+                            raise SPDXException(None, 'Exception %s missing license %s' %(ex, lic))
+                        spdx.exceptions[exception].append(lic)
+
+                elif l.startswith("License-Text:"):
+                    if exception:
+                        if not len(spdx.exceptions[exception]):
+                            raise SPDXException(el, 'Exception %s is missing SPDX-Licenses' %excid)
+                        spdx.exception_files += 1
+                    else:
+                        spdx.license_files += 1
+                    break
+    return spdx
+
+class id_parser(object):
+
+    reserved = [ 'AND', 'OR', 'WITH' ]
+    tokens = [ 'LPAR', 'RPAR', 'ID', 'EXC' ] + reserved
+
+    precedence = ( ('nonassoc', 'AND', 'OR'), )
+
+    t_ignore = ' \t'
+
+    def __init__(self, spdx):
+        self.spdx = spdx
+        self.lasttok = None
+        self.lastid = None
+        self.lexer = lex.lex(module = self, reflags = re.UNICODE)
+        # Initialize the parser. No debug file and no parser rules stored on disk
+        # The rules are small enough to be generated on the fly
+        self.parser = yacc.yacc(module = self, write_tables = False, debug = False)
+        self.lines_checked = 0
+        self.checked = 0
+        self.spdx_valid = 0
+        self.spdx_errors = 0
+        self.curline = 0
+        self.deepest = 0
+
+    # Validate License and Exception IDs
+    def validate(self, tok):
+        id = tok.value.upper()
+        if tok.type == 'ID':
+            if not id in self.spdx.licenses:
+                raise ParserException(tok, 'Invalid License ID')
+            self.lastid = id
+        elif tok.type == 'EXC':
+            if not self.spdx.exceptions.has_key(id):
+                raise ParserException(tok, 'Invalid Exception ID')
+            if self.lastid not in self.spdx.exceptions[id]:
+                raise ParserException(tok, 'Exception not valid for license %s' %self.lastid)
+            self.lastid = None
+        elif tok.type != 'WITH':
+            self.lastid = None
+
+    # Lexer functions
+    def t_RPAR(self, tok):
+        r'\)'
+        self.lasttok = tok.type
+        return tok
+
+    def t_LPAR(self, tok):
+        r'\('
+        self.lasttok = tok.type
+        return tok
+
+    def t_ID(self, tok):
+        r'[A-Za-z.0-9\-+]+'
+
+        if self.lasttok == 'EXC':
+            print(tok)
+            raise ParserException(tok, 'Missing parentheses')
+
+        tok.value = tok.value.strip()
+        val = tok.value.upper()
+
+        if val in self.reserved:
+            tok.type = val
+        elif self.lasttok == 'WITH':
+            tok.type = 'EXC'
+
+        self.lasttok = tok.type
+        self.validate(tok)
+        return tok
+
+    def t_error(self, tok):
+        raise ParserException(tok, 'Invalid token')
+
+    def p_expr(self, p):
+        '''expr : ID
+                | ID WITH EXC
+                | expr AND expr
+                | expr OR expr
+                | LPAR expr RPAR'''
+        pass
+
+    def p_error(self, p):
+        if not p:
+            raise ParserException(None, 'Unfinished license expression')
+        else:
+            raise ParserException(p, 'Syntax error')
+
+    def parse(self, expr):
+        self.lasttok = None
+        self.lastid = None
+        self.parser.parse(expr, lexer = self.lexer)
+
+    def parse_lines(self, fd, maxlines, fname):
+        self.checked += 1
+        self.curline = 0
+        try:
+            for line in fd:
+                self.curline += 1
+                if self.curline > maxlines:
+                    break
+                self.lines_checked += 1
+                if line.find("SPDX-License-Identifier:") < 0:
+                    continue
+                expr = line.split(':')[1].replace('*/', '').strip()
+                self.parse(expr)
+                self.spdx_valid += 1
+                #
+                # Should we check for more SPDX ids in the same file and
+                # complain if there are any?
+                #
+                break
+
+        except ParserException as pe:
+            if pe.tok:
+                col = line.find(expr) + pe.tok.lexpos
+                tok = pe.tok.value
+                sys.stdout.write('%s: %d:%d %s: %s\n' %(fname, self.curline, col, pe.txt, tok))
+            else:
+                sys.stdout.write('%s: %d:0 %s\n' %(fname, self.curline, col, pe.txt))
+            self.spdx_errors += 1
+
+if __name__ == '__main__':
+
+    ap = ArgumentParser(description='SPDX expression checker')
+    ap.add_argument('-m', '--maxlines', type=int, default=15,
+                    help='Maximum number of lines to scan in a file. Default 15')
+    ap.add_argument('-s', '--stdin', action='store_true', help='Read from stdin. If not set scan full git tree.')
+    ap.add_argument('-v', '--verbose', action='store_true', help='Verbose statistics output')
+    args = ap.parse_args()
+
+    try:
+        # Use git to get the valid license expressions
+        repo = git.Repo(os.getcwd())
+        assert not repo.bare
+
+        # Initialize SPDX data
+        spdx = read_spdxdata(repo)
+
+        # Initilize the parser
+        parser = id_parser(spdx)
+
+    except SPDXException as se:
+        if se.el:
+            sys.stderr.write('%s: %s\n' %(se.el.path, se.txt))
+        else:
+            sys.stderr.write('%s\n' %se.txt)
+        sys.exit(1)
+
+    except Exception as ex:
+        sys.stderr.write('FAIL: %s\n' %ex)
+        sys.stderr.write('%s\n' %traceback.format_exc())
+        sys.exit(1)
+
+    try:
+        if args.stdin:
+            parser.parse_lines(sys.stdin, args.maxlines, '-')
+        else:
+            for el in repo.heads.master.commit.tree.traverse():
+                # Exclude stuff which would make pointless noise
+                # FIXME: Put this somewhere more sensible
+                if el.path.startswith("LICENSES"):
+                    continue
+                if el.path.find("license-rules.rst") >= 0:
+                    continue
+                if el.path == 'scripts/checkpatch.pl':
+                    continue
+                if not os.path.isfile(el.path):
+                    continue
+                parser.parse_lines(open(el.path), args.maxlines, el.path)
+
+            if args.verbose:
+                sys.stderr.write('\n')
+                sys.stderr.write('License files:     %12d\n' %spdx.license_files)
+                sys.stderr.write('Exception files:   %12d\n' %spdx.exception_files)
+                sys.stderr.write('License IDs        %12d\n' %len(spdx.licenses))
+                sys.stderr.write('Exception IDs      %12d\n' %len(spdx.exceptions))
+                sys.stderr.write('\n')
+                sys.stderr.write('Files checked:     %12d\n' %parser.checked)
+                sys.stderr.write('Lines checked:     %12d\n' %parser.lines_checked)
+                sys.stderr.write('Files with SPDX:   %12d\n' %parser.spdx_valid)
+                sys.stderr.write('Files with errors: %12d\n' %parser.spdx_errors)
+
+            sys.exit(0)
+
+    except Exception as ex:
+        sys.stderr.write('FAIL: %s\n' %ex)
+        sys.stderr.write('%s\n' %traceback.format_exc())
+        sys.exit(1)
