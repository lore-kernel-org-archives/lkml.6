Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeFEWuT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:50:19 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:34864 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932074AbeFEWuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:50:11 -0400
X-Spam-Flag: NO
X-Spam-Score: -1
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 6/6] doc:it_IT: translation for doc-guide
Date: Wed,  6 Jun 2018 00:49:03 +0200
Message-Id: <20180605224903.9483-7-federico.vaga@vaga.pv.it>
In-Reply-To: <20180605224903.9483-1-federico.vaga@vaga.pv.it>
References: <20180605224903.9483-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the complete translation of 'doc-guide' in Italian.

Please note that code comments will stay in English because
thats the language that everyone should use to write comments.

External files (svg, dot) are taken from Documentation/doc-guide
instead of copying them into the Italian translation.

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
Signed-off-by: Alessia Mantegazza <amantegazza@vaga.pv.it>
---
 .../translations/it_IT/doc-guide/index.rst         |  24 +
 .../translations/it_IT/doc-guide/kernel-doc.rst    | 554 +++++++++++++++++++++
 .../translations/it_IT/doc-guide/parse-headers.rst | 196 ++++++++
 .../translations/it_IT/doc-guide/sphinx.rst        | 457 +++++++++++++++++
 Documentation/translations/it_IT/index.rst         |   5 +
 5 files changed, 1236 insertions(+)
 create mode 100644 Documentation/translations/it_IT/doc-guide/index.rst
 create mode 100644 Documentation/translations/it_IT/doc-guide/kernel-doc.rst
 create mode 100644 Documentation/translations/it_IT/doc-guide/parse-headers.rst
 create mode 100644 Documentation/translations/it_IT/doc-guide/sphinx.rst

diff --git a/Documentation/translations/it_IT/doc-guide/index.rst b/Documentation/translations/it_IT/doc-guide/index.rst
new file mode 100644
index 000000000000..7a6562b547ee
--- /dev/null
+++ b/Documentation/translations/it_IT/doc-guide/index.rst
@@ -0,0 +1,24 @@
+.. include:: ../disclaimer-ita.rst
+
+.. note:: Per leggere la documentazione originale in inglese:
+	  :ref:`Documentation/doc-guide/index.rst <doc_guide>`
+
+.. _it_doc_guide:
+
+==========================================
+Come scrivere la documentazione del kernel
+==========================================
+
+.. toctree::
+   :maxdepth: 1
+
+   sphinx.rst
+   kernel-doc.rst
+   parse-headers.rst
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
new file mode 100644
index 000000000000..2bf1c1e2f394
--- /dev/null
+++ b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
@@ -0,0 +1,554 @@
+.. include:: ../disclaimer-ita.rst
+
+.. note:: Per leggere la documentazione originale in inglese:
+	  :ref:`Documentation/doc-guide/index.rst <doc_guide>`
+
+.. _it_kernel_doc:
+
+Scrivere i commenti in kernel-doc
+=================================
+
+Nei file sorgenti del kernel Linux potrete trovare commenti di documentazione
+strutturanti secondo il formato kernel-doc. Essi possono descrivere funzioni,
+tipi di dati, e l'architettura del codice.
+
+.. note:: Il formato kernel-doc può sembrare simile a gtk-doc o Doxygen ma
+   in realtà è molto differente per ragioni storiche. I sorgenti del kernel
+   contengono decine di migliaia di commenti kernel-doc. Siete pregati
+   d'attenervi allo stile qui descritto.
+
+La struttura kernel-doc è estratta a partire dai commenti; da questi viene
+generato il `dominio Sphinx per il C`_ con un'adeguata descrizione per le
+funzioni ed i tipi di dato con i loro relativi collegamenti. Le descrizioni
+vengono filtrare per cercare i riferimenti ed i marcatori.
+
+Vedere di seguito per maggiori dettagli.
+
+.. _`dominio Sphinx per il C`: http://www.sphinx-doc.org/en/stable/domains.html
+
+Tutte le funzioni esportate verso i moduli esterni utilizzando
+``EXPORT_SYMBOL`` o ``EXPORT_SYMBOL_GPL`` dovrebbero avere un commento
+kernel-doc. Quando l'intenzione è di utilizzarle nei moduli, anche le funzioni
+e le strutture dati nei file d'intestazione dovrebbero avere dei commenti
+kernel-doc.
+
+È considerata una buona pratica quella di fornire una documentazione formattata
+secondo kernel-doc per le funzioni che sono visibili da altri file del kernel
+(ovvero, che non siano dichiarate utilizzando ``static``). Raccomandiamo,
+inoltre, di fornire una documentazione kernel-doc anche per procedure private
+(ovvero, dichiarate "static") al fine di fornire una struttura più coerente
+dei sorgenti. Quest'ultima raccomandazione ha una priorità più bassa ed è a
+discrezione dal manutentore (MAINTAINER) del file sorgente.
+
+
+
+Sicuramente la documentazione formattata con kernel-doc è necessaria per
+le funzioni che sono esportate verso i moduli esterni utilizzando
+``EXPORT_SYMBOL`` o ``EXPORT_SYMBOL_GPL``.
+
+Cerchiamo anche di fornire una documentazione formattata secondo kernel-doc
+per le funzioni che sono visibili da altri file del kernel (ovvero, che non
+siano dichiarate utilizzando "static")
+
+Raccomandiamo, inoltre, di fornire una documentazione formattata con kernel-doc
+anche per procedure private (ovvero, dichiarate "static") al fine di fornire
+una struttura più coerente dei sorgenti. Questa raccomandazione ha una priorità
+più bassa ed è a discrezione dal manutentore (MAINTAINER) del file sorgente.
+
+Le strutture dati visibili nei file di intestazione dovrebbero essere anch'esse
+documentate utilizzando commenti formattati con kernel-doc.
+
+Come formattare i commenti kernel-doc
+-------------------------------------
+
+I commenti kernel-doc iniziano con il marcatore ``/**``. Il programma
+``kernel-doc`` estrarrà i commenti marchiati in questo modo. Il resto
+del commento è formattato come un normale commento multilinea, ovvero
+con un asterisco all'inizio d'ogni riga e che si conclude con ``*/``
+su una riga separata.
+
+I commenti kernel-doc di funzioni e tipi dovrebbero essere posizionati
+appena sopra la funzione od il tipo che descrivono. Questo allo scopo di
+aumentare la probabilità che chi cambia il codice si ricordi di aggiornare
+anche la documentazione. I commenti kernel-doc di tipo più generale possono
+essere posizionati ovunque nel file.
+
+Al fine di verificare che i commenti siano formattati correttamente, potete
+eseguire il programma ``kernel-doc`` con un livello di verbosità alto e senza
+che questo produca alcuna documentazione. Per esempio::
+
+	scripts/kernel-doc -v -none drivers/foo/bar.c
+
+Il formato della documentazione è verificato della procedura di generazione
+del kernel quando viene richiesto di effettuare dei controlli extra con GCC::
+
+	make W=n
+
+Documentare le funzioni
+------------------------
+
+Generalmente il formato di un commento kernel-doc per funzioni e
+macro simil-funzioni è il seguente::
+
+  /**
+   * function_name() - Brief description of function.
+   * @arg1: Describe the first argument.
+   * @arg2: Describe the second argument.
+   *        One can provide multiple line descriptions
+   *        for arguments.
+   *
+   * A longer description, with more discussion of the function function_name()
+   * that might be useful to those using or modifying it. Begins with an
+   * empty comment line, and may include additional embedded empty
+   * comment lines.
+   *
+   * The longer description may have multiple paragraphs.
+   *
+   * Context: Describes whether the function can sleep, what locks it takes,
+   *          releases, or expects to be held. It can extend over multiple
+   *          lines.
+   * Return: Describe the return value of foobar.
+   *
+   * The return value description can also have multiple paragraphs, and should
+   * be placed at the end of the comment block.
+   */
+
+La descrizione introduttiva (*brief description*) che segue il nome della
+funzione può continuare su righe successive e termina con la descrizione di
+un argomento, una linea di commento vuota, oppure la fine del commento.
+
+Parametri delle funzioni
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Ogni argomento di una funzione dovrebbe essere descritto in ordine, subito
+dopo la descrizione introduttiva.  Non lasciare righe vuote né fra la
+descrizione introduttiva e quella degli argomenti, né fra gli argomenti.
+
+Ogni ``@argument:`` può estendersi su più righe.
+
+.. note::
+
+   Se la descrizione di ``@argument:`` si estende su più righe,
+   la continuazione dovrebbe iniziare alla stessa colonna della riga
+   precedente::
+
+      * @argument: some long description
+      *            that continues on next lines
+
+   or::
+
+      * @argument:
+      *		some long description
+      *		that continues on next lines
+
+Se una funzione ha un numero variabile di argomento, la sua descrizione
+dovrebbe essere scritta con la notazione kernel-doc::
+
+      * @...: description
+
+Contesto delle funzioni
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Il contesto in cui le funzioni vengono chiamate viene descritto in una
+sezione chiamata ``Context``. Questo dovrebbe informare sulla possibilità
+che una funzione dorma (*sleep*) o che possa essere chiamata in un contesto
+d'interruzione, così come i *lock* che prende, rilascia e che si aspetta che
+vengano presi dal chiamante.
+
+Esempi::
+
+  * Context: Any context.
+  * Context: Any context. Takes and releases the RCU lock.
+  * Context: Any context. Expects <lock> to be held by caller.
+  * Context: Process context. May sleep if @gfp flags permit.
+  * Context: Process context. Takes and releases <mutex>.
+  * Context: Softirq or process context. Takes and releases <lock>, BH-safe.
+  * Context: Interrupt context.
+
+Valore di ritorno
+~~~~~~~~~~~~~~~~~
+
+Il valore di ritorno, se c'è, viene descritto in una sezione dedicata di nome
+``Return``.
+
+.. note::
+
+  #) La descrizione multiriga non riconosce il termine d'una riga, per cui
+     se provate a formattare bene il vostro testo come nel seguente esempio::
+
+	* Return:
+	* 0 - OK
+	* -EINVAL - invalid argument
+	* -ENOMEM - out of memory
+
+     le righe verranno unite e il risultato sarà::
+
+	Return: 0 - OK -EINVAL - invalid argument -ENOMEM - out of memory
+
+     Quindi, se volete che le righe vengano effettivamente generate, dovete
+     utilizzare una lista ReST, ad esempio::
+
+      * Return:
+      * * 0		- OK to runtime suspend the device
+      * * -EBUSY	- Device should not be runtime suspended
+
+  #) Se il vostro testo ha delle righe che iniziano con una frase seguita dai
+     due punti, allora ognuna di queste frasi verrà considerata come il nome
+     di una nuova sezione, e probabilmente non produrrà gli effetti desiderati.
+
+Documentare strutture, unioni ed enumerazioni
+---------------------------------------------
+
+Generalmente il formato di un commento kernel-doc per struct, union ed enum è::
+
+  /**
+   * struct struct_name - Brief description.
+   * @member1: Description of member1.
+   * @member2: Description of member2.
+   *           One can provide multiple line descriptions
+   *           for members.
+   *
+   * Description of the structure.
+   */
+
+Nell'esempio qui sopra, potete sostituire ``struct`` con ``union`` o ``enum``
+per descrivere unioni ed enumerati. ``member`` viene usato per indicare i
+membri di strutture ed unioni, ma anche i valori di un tipo enumerato.
+
+La descrizione introduttiva (*brief description*) che segue il nome della
+funzione può continuare su righe successive e termina con la descrizione di
+un argomento, una linea di commento vuota, oppure la fine del commento.
+
+Membri
+~~~~~~
+
+I membri di strutture, unioni ed enumerati devo essere documentati come i
+parametri delle funzioni; seguono la descrizione introduttiva e possono
+estendersi su più righe.
+
+All'interno d'una struttura o d'un unione, potete utilizzare le etichette
+``private:`` e ``public:``. I campi che sono nell'area ``private:`` non
+verranno inclusi nella documentazione finale.
+
+Le etichette ``private:`` e ``public:`` devono essere messe subito dopo
+il marcatore di un commento ``/*``. Opzionalmente, possono includere commenti
+fra ``:`` e il marcatore di fine commento ``*/``.
+
+Esempio::
+
+  /**
+   * struct my_struct - short description
+   * @a: first member
+   * @b: second member
+   * @d: fourth member
+   *
+   * Longer description
+   */
+  struct my_struct {
+      int a;
+      int b;
+  /* private: internal use only */
+      int c;
+  /* public: the next one is public */
+      int d;
+  };
+
+Strutture ed unioni annidate
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+È possibile documentare strutture ed unioni annidate, ad esempio::
+
+      /**
+       * struct nested_foobar - a struct with nested unions and structs
+       * @memb1: first member of anonymous union/anonymous struct
+       * @memb2: second member of anonymous union/anonymous struct
+       * @memb3: third member of anonymous union/anonymous struct
+       * @memb4: fourth member of anonymous union/anonymous struct
+       * @bar: non-anonymous union
+       * @bar.st1: struct st1 inside @bar
+       * @bar.st2: struct st2 inside @bar
+       * @bar.st1.memb1: first member of struct st1 on union bar
+       * @bar.st1.memb2: second member of struct st1 on union bar
+       * @bar.st2.memb1: first member of struct st2 on union bar
+       * @bar.st2.memb2: second member of struct st2 on union bar
+       */
+      struct nested_foobar {
+        /* Anonymous union/struct*/
+        union {
+          struct {
+            int memb1;
+            int memb2;
+        }
+          struct {
+            void *memb3;
+            int memb4;
+          }
+        }
+        union {
+          struct {
+            int memb1;
+            int memb2;
+          } st1;
+          struct {
+            void *memb1;
+            int memb2;
+          } st2;
+        } bar;
+      };
+
+.. note::
+
+   #) Quando documentate una struttura od unione annidata, ad esempio
+      di nome ``foo``, il suo campo ``bar`` dev'essere documentato
+      usando ``@foo.bar:``
+   #) Quando la struttura od unione annidata è anonima, il suo campo
+      ``bar`` dev'essere documentato usando ``@bar:``
+
+Commenti in linea per la documentazione dei membri
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+I membri d'una struttura possono essere documentati in linea all'interno
+della definizione stessa. Ci sono due stili: una singola riga di commento
+che inizia con ``/**`` e finisce con ``*/``; commenti multi riga come
+qualsiasi altro commento kernel-doc::
+
+  /**
+   * struct foo - Brief description.
+   * @foo: The Foo member.
+   */
+  struct foo {
+        int foo;
+        /**
+         * @bar: The Bar member.
+         */
+        int bar;
+        /**
+         * @baz: The Baz member.
+         *
+         * Here, the member description may contain several paragraphs.
+         */
+        int baz;
+        union {
+                /** @foobar: Single line description. */
+                int foobar;
+        };
+        /** @bar2: Description for struct @bar2 inside @foo */
+        struct {
+                /**
+                 * @bar2.barbar: Description for @barbar inside @foo.bar2
+                 */
+                int barbar;
+        } bar2;
+  };
+
+
+Documentazione dei tipi di dato
+-------------------------------
+Generalmente il formato di un commento kernel-doc per typedef è
+il seguente::
+
+  /**
+   * typedef type_name - Brief description.
+   *
+   * Description of the type.
+   */
+
+Anche i tipi di dato per prototipi di funzione possono essere documentati::
+
+  /**
+   * typedef type_name - Brief description.
+   * @arg1: description of arg1
+   * @arg2: description of arg2
+   *
+   * Description of the type.
+   *
+   * Context: Locking context.
+   * Return: Meaning of the return value.
+   */
+   typedef void (*type_name)(struct v4l2_ctrl *arg1, void *arg2);
+
+Marcatori e riferimenti
+-----------------------
+
+All'interno dei commenti di tipo kernel-doc vengono riconosciuti i seguenti
+*pattern* che vengono convertiti in marcatori reStructuredText ed in riferimenti
+del `dominio Sphinx per il C`_.
+
+.. attention:: Questi sono riconosciuti **solo** all'interno di commenti
+               kernel-doc, e **non** all'interno di documenti reStructuredText.
+
+``funcname()``
+  Riferimento ad una funzione.
+
+``@parameter``
+  Nome di un parametro di una funzione (nessun riferimento, solo formattazione).
+
+``%CONST``
+  Il nome di una costante (nessun riferimento, solo formattazione)
+
+````literal````
+  Un blocco di testo che deve essere riportato così com'è. La rappresentazione
+  finale utilizzerà caratteri a ``spaziatura fissa``.
+
+  Questo è utile se dovete utilizzare caratteri speciali che altrimenti
+  potrebbero assumere un significato diverso in kernel-doc o in reStructuredText
+
+  Questo è particolarmente utile se dovete scrivere qualcosa come ``%ph``
+  all'interno della descrizione di una funzione.
+
+``$ENVVAR``
+  Il nome di una variabile d'ambiente (nessun riferimento, solo formattazione).
+
+``&struct name``
+  Riferimento ad una struttura.
+
+``&enum name``
+  Riferimento ad un'enumerazione.
+
+``&typedef name``
+  Riferimento ad un tipo di dato.
+
+``&struct_name->member`` or ``&struct_name.member``
+  Riferimento ad un membro di una struttura o di un'unione. Il riferimento sarà
+  la struttura o l'unione, non il memembro.
+
+``&name``
+  Un generico riferimento ad un tipo. Usate, preferibilmente, il riferimento
+  completo come descritto sopra. Questo è dedicato ai commenti obsoleti.
+
+Riferimenti usando reStructuredText
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Per fare riferimento a funzioni e tipi di dato definiti nei commenti kernel-doc
+all'interno dei documenti reStructuredText, utilizzate i riferimenti dal
+`dominio Sphinx per il C`_. Per esempio::
+
+  See function :c:func:`foo` and struct/union/enum/typedef :c:type:`bar`.
+
+Nonostante il riferimento ai tipi di dato funzioni col solo nome,
+ovvero senza specificare struct/union/enum/typedef, potreste preferire il
+seguente::
+
+  See :c:type:`struct foo <foo>`.
+  See :c:type:`union bar <bar>`.
+  See :c:type:`enum baz <baz>`.
+  See :c:type:`typedef meh <meh>`.
+
+Questo produce dei collegamenti migliori, ed è in linea con il modo in cui
+kernel-doc gestisce i riferimenti.
+
+Per maggiori informazioni, siete pregati di consultare la documentazione
+del `dominio Sphinx per il C`_.
+
+Commenti per una documentazione generale
+----------------------------------------
+
+Al fine d'avere il codice ed i commenti nello stesso file, potete includere
+dei blocchi di documentazione kernel-doc con un formato libero invece
+che nel formato specifico per funzioni, strutture, unioni, enumerati o tipi
+di dato. Per esempio, questo tipo di commento potrebbe essere usato per la
+spiegazione delle operazioni di un driver o di una libreria
+
+Questo s'ottiene utilizzando la parola chiave ``DOC:`` a cui viene associato
+un titolo.
+
+Generalmente il formato di un commento generico o di visione d'insieme è
+il seguente::
+
+  /**
+   * DOC: Theory of Operation
+   *
+   * The whizbang foobar is a dilly of a gizmo. It can do whatever you
+   * want it to do, at any time. It reads your mind. Here's how it works.
+   *
+   * foo bar splat
+   *
+   * The only drawback to this gizmo is that is can sometimes damage
+   * hardware, software, or its subject(s).
+   */
+
+Il titolo che segue ``DOC:`` funziona da intestazione all'interno del file
+sorgente, ma anche come identificatore per l'estrazione di questi commenti di
+documentazione. Quindi, il titolo dev'essere unico all'interno del file.
+
+Includere i commenti di tipo kernel-doc
+=======================================
+
+I commenti di documentazione possono essere inclusi in un qualsiasi documento
+di tipo reStructuredText mediante l'apposita direttiva nell'estensione
+kernel-doc per Sphinx.
+
+Le direttive kernel-doc sono nel formato::
+
+  .. kernel-doc:: source
+     :option:
+
+Il campo *source* è il percorso ad un file sorgente, relativo alla cartella
+principale dei sorgenti del kernel. La direttiva supporta le seguenti opzioni:
+
+export: *[source-pattern ...]*
+  Include la documentazione per tutte le funzioni presenti nel file sorgente
+  (*source*) che sono state esportate utilizzando ``EXPORT_SYMBOL`` o
+  ``EXPORT_SYMBOL_GPL`` in *source* o in qualsiasi altro *source-pattern*
+  specificato.
+
+  Il campo *source-patter* è utile quando i commenti kernel-doc sono stati
+  scritti nei file d'intestazione, mentre ``EXPORT_SYMBOL`` e
+  ``EXPORT_SYMBOL_GPL`` si trovano vicino alla definizione delle funzioni.
+
+  Esempi::
+
+    .. kernel-doc:: lib/bitmap.c
+       :export:
+
+    .. kernel-doc:: include/net/mac80211.h
+       :export: net/mac80211/*.c
+
+internal: *[source-pattern ...]*
+  Include la documentazione per tutte le funzioni ed i tipi presenti nel file
+  sorgente (*source*) che **non** sono stati esportati utilizzando
+  ``EXPORT_SYMBOL`` o ``EXPORT_SYMBOL_GPL`` né in *source* né in qualsiasi
+  altro *source-pattern* specificato.
+
+  Esempio::
+
+    .. kernel-doc:: drivers/gpu/drm/i915/intel_audio.c
+       :internal:
+
+doc: *title*
+  Include la documentazione del paragrafo ``DOC:`` identificato dal titolo
+  (*title*) all'interno del file sorgente (*source*). Gli spazi in *title* sono
+  permessi; non virgolettate *title*. Il campo *title* è utilizzato per
+  identificare un paragrafo e per questo non viene incluso nella documentazione
+  finale. Verificate d'avere l'intestazione appropriata nei documenti
+  reStructuredText.
+
+  Esempio::
+
+    .. kernel-doc:: drivers/gpu/drm/i915/intel_audio.c
+       :doc: High Definition Audio over HDMI and Display Port
+
+functions: *function* *[...]*
+  Dal file sorgente (*source*) include la documentazione per le funzioni
+  elencate (*function*).
+
+  Esempio::
+
+    .. kernel-doc:: lib/bitmap.c
+       :functions: bitmap_parselist bitmap_parselist_user
+
+Senza alcuna opzione, la direttiva kernel-doc include tutti i commenti di
+documentazione presenti nel file sorgente (*source*).
+
+L'estensione kernel-doc fa parte dei sorgenti del kernel, la si può trovare
+in ``Documentation/sphinx/kerneldoc.py``. Internamente, viene utilizzato
+lo script ``scripts/kernel-doc`` per estrarre i commenti di documentazione
+dai file sorgenti.
+
+Come utilizzare kernel-doc per generare pagine man
+--------------------------------------------------
+
+Se volete utilizzare kernel-doc solo per generare delle pagine man, potete
+farlo direttamente dai sorgenti del kernel::
+
+  $ scripts/kernel-doc -man $(git grep -l '/\*\*' -- :^Documentation :^tools) | scripts/split-man.pl /tmp/man
diff --git a/Documentation/translations/it_IT/doc-guide/parse-headers.rst b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
new file mode 100644
index 000000000000..b38918ca637e
--- /dev/null
+++ b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
@@ -0,0 +1,196 @@
+.. include:: ../disclaimer-ita.rst
+
+.. note:: Per leggere la documentazione originale in inglese:
+	  :ref:`Documentation/doc-guide/index.rst <doc_guide>`
+
+=========================================
+Includere gli i file di intestazione uAPI
+=========================================
+
+Qualche volta è utile includere dei file di intestazione e degli esempi di codice C
+al fine di descrivere l'API per lo spazio utente e per generare dei riferimenti
+fra il codice e la documentazione. Aggiungere i riferimenti ai file dell'API
+dello spazio utente ha ulteriori vantaggi: Sphinx genererà dei messaggi
+d'avviso se un simbolo non viene trovato nella documentazione. Questo permette
+di mantenere allineate la documentazione della uAPI (API spazio utente)
+con le modifiche del kernel.
+Il programma :ref:`parse_headers.pl <it_parse_headers>` genera questi riferimenti.
+Esso dev'essere invocato attraverso un Makefile, mentre si genera la
+documentazione. Per avere un esempio su come utilizzarlo all'interno del kernel
+consultate ``Documentation/media/Makefile``.
+
+.. _it_parse_headers:
+
+parse_headers.pl
+^^^^^^^^^^^^^^^^
+
+NOME
+****
+
+
+parse_headers.pl - analizza i file C al fine di identificare funzioni,
+strutture, enumerati e definizioni, e creare riferimenti per Sphinx
+
+SINTASSI
+********
+
+
+\ **parse_headers.pl**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
+
+Dove <options> può essere: --debug, --usage o --help.
+
+
+OPZIONI
+*******
+
+
+
+\ **--debug**\
+
+ Lo script viene messo in modalità verbosa, utile per il debugging.
+
+
+\ **--usage**\
+
+ Mostra un messaggio d'aiuto breve e termina.
+
+
+\ **--help**\
+
+ Mostra un messaggio d'aiuto dettagliato e termina.
+
+
+DESCRIZIONE
+***********
+
+Converte un file d'intestazione o un file sorgente C (C_FILE) in un testo
+ReStructuredText incluso mediante il blocco ..parsed-literal
+con riferimenti alla documentazione che descrive l'API. Opzionalmente,
+il programma accetta anche un altro file (EXCEPTIONS_FILE) che
+descrive quali elementi debbano essere ignorati o il cui riferimento
+deve puntare ad elemento diverso dal predefinito.
+
+Il file generato sarà disponibile in (OUT_FILE).
+
+Il programma è capace di identificare *define*, funzioni, strutture,
+tipi di dato, enumerati e valori di enumerati, e di creare i riferimenti
+per ognuno di loro. Inoltre, esso è capace di distinguere le #define
+utilizzate per specificare i comandi ioctl di Linux.
+
+Il file EXCEPTIONS_FILE contiene due tipi di dichiarazioni:
+\ **ignore**\  o \ **replace**\ .
+
+La sintassi per ignore è:
+
+ignore \ **tipo**\  \ **nome**\
+
+La dichiarazione \ **ignore**\  significa che non verrà generato alcun
+riferimento per il simbolo \ **name**\  di tipo \ **tipo**\ .
+
+
+La sintassi per replace è:
+
+replace \ **tipo**\  \ **nome**\  \ **nuovo_valore**\
+
+La dichiarazione \ **replace**\  significa che verrà generato un
+riferimento per il simbolo \ **name**\ di tipo \ **tipo**\ , ma, invece
+di utilizzare il valore predefinito, verrà utilizzato il valore
+\ **nuovo_valore**\ .
+
+Per entrambe le dichiarazioni, il \ **tipo**\  può essere uno dei seguenti:
+
+
+\ **ioctl**\
+
+ La dichiarazione ignore o replace verrà applicata su definizioni di ioctl
+ come la seguente:
+
+ #define	VIDIOC_DBG_S_REGISTER 	 _IOW('V', 79, struct v4l2_dbg_register)
+
+
+
+\ **define**\
+
+ La dichiarazione ignore o replace verrà applicata su una qualsiasi #define
+ trovata in C_FILE.
+
+
+
+\ **typedef**\
+
+ La dichiarazione ignore o replace verrà applicata ad una dichiarazione typedef
+ in C_FILE.
+
+
+
+\ **struct**\
+
+ La dichiarazione ignore o replace verrà applicata ai nomi di strutture
+ in C_FILE.
+
+
+
+\ **enum**\
+
+ La dichiarazione ignore o replace verrà applicata ai nomi di enumerati
+ in C_FILE.
+
+
+
+\ **symbol**\
+
+ La dichiarazione ignore o replace verrà applicata ai nomi di valori di
+ enumerati in C_FILE.
+
+ Per le dichiarazioni di tipo replace, il campo \ **new_value**\  utilizzerà
+ automaticamente i riferimenti :c:type: per \ **typedef**\ , \ **enum**\  e
+ \ **struct**\. Invece, utilizzerà :ref: per \ **ioctl**\ , \ **define**\  e
+ \ **symbol**\. Il tipo di riferimento può essere definito esplicitamente
+ nella dichiarazione stessa.
+
+
+ESEMPI
+******
+
+
+ignore define _VIDEODEV2_H
+
+
+Ignora una definizione #define _VIDEODEV2_H nel file C_FILE.
+
+ignore symbol PRIVATE
+
+
+In un enumerato come il seguente:
+
+enum foo { BAR1, BAR2, PRIVATE };
+
+Non genererà alcun riferimento per \ **PRIVATE**\ .
+
+replace symbol BAR1 :c:type:\`foo\`
+replace symbol BAR2 :c:type:\`foo\`
+
+
+In un enumerato come il seguente:
+
+enum foo { BAR1, BAR2, PRIVATE };
+
+Genererà un riferimento ai valori BAR1 e BAR2 dal simbolo foo nel dominio C.
+
+
+BUGS
+****
+
+Riferire ogni malfunzionamento a Mauro Carvalho Chehab <mchehab@s-opensource.com>
+
+
+COPYRIGHT
+*********
+
+
+Copyright (c) 2016 by Mauro Carvalho Chehab <mchehab@s-opensource.com>.
+
+Licenza GPLv2: GNU GPL version 2 <http://gnu.org/licenses/gpl.html>.
+
+Questo è software libero: siete liberi di cambiarlo e ridistribuirlo.
+Non c'è alcuna garanzia, nei limiti permessi dalla legge.
diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst b/Documentation/translations/it_IT/doc-guide/sphinx.rst
new file mode 100644
index 000000000000..474b7e127893
--- /dev/null
+++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
@@ -0,0 +1,457 @@
+.. include:: ../disclaimer-ita.rst
+
+.. note:: Per leggere la documentazione originale in inglese:
+	  :ref:`Documentation/doc-guide/index.rst <doc_guide>`
+
+Introduzione
+============
+
+Il kernel Linux usa `Sphinx`_ per la generazione della documentazione a partire
+dai file `reStructuredText`_ che si trovano nella cartella ``Documentation``.
+Per generare la documentazione in HTML o PDF, usate comandi ``make htmldocs`` o
+``make pdfdocs``. La documentazione così generata sarà disponibile nella
+cartella ``Documentation/output``.
+
+.. _Sphinx: http://www.sphinx-doc.org/
+.. _reStructuredText: http://docutils.sourceforge.net/rst.html
+
+I file reStructuredText possono contenere delle direttive che permettono di
+includere i commenti di documentazione, o di tipo kernel-doc, dai file
+sorgenti.
+Solitamente questi commenti sono utilizzati per descrivere le funzioni, i tipi
+e l'architettura del codice. I commenti di tipo kernel-doc hanno una struttura
+e formato speciale, ma a parte questo vengono processati come reStructuredText.
+
+Inoltre, ci sono migliaia di altri documenti in formato testo sparsi nella
+cartella ``Documentation``. Alcuni di questi verranno probabilmente convertiti,
+nel tempo, in formato reStructuredText, ma la maggior parte di questi rimarranno
+in formato testo.
+
+.. _it_sphinx_install:
+
+Installazione Sphinx
+====================
+
+I marcatori ReST utilizzati nei file in Documentation/ sono pensati per essere
+processati da ``Sphinx`` nella versione 1.3 o superiore. Se desiderate produrre
+un documento PDF è raccomandato l'utilizzo di una versione superiore alle 1.4.6.
+
+Esiste uno script che verifica i requisiti Sphinx. Per ulteriori dettagli
+consultate :ref:`it_sphinx-pre-install`.
+
+La maggior parte delle distribuzioni Linux forniscono Sphinx, ma l'insieme dei
+programmi e librerie è fragile e non è raro che dopo un aggiornamento di
+Sphinx, o qualche altro pacchetto Python, la documentazione non venga più
+generata correttamente.
+
+Un modo per evitare questo genere di problemi è quello di utilizzare una
+versione diversa da quella fornita dalla vostra distribuzione. Per fare questo,
+vi raccomandiamo di installare Sphinx dentro ad un ambiente virtuale usando
+``virtualenv-3`` o ``virtualenv`` a seconda di come Python 3 è stato
+pacchettizzato dalla vostra distribuzione.
+
+.. note::
+
+   #) Le versioni di Sphinx inferiori alla 1.5 non funzionano bene
+      con il pacchetto Python docutils versione 0.13.1 o superiore.
+      Se volete usare queste versioni, allora dovere eseguire
+      ``pip install 'docutils==0.12'``.
+
+   #) Viene raccomandato l'uso del tema RTD per la documentazione in HTML.
+      A seconda della versione di Sphinx, potrebbe essere necessaria
+      l'installazione tramite il comando ``pip install sphinx_rtd_theme``.
+
+   #) Alcune pagine ReST contengono delle formule matematiche. A causa del
+      modo in cui Sphinx funziona, queste espressioni sono scritte
+      utilizzando LaTeX. Per una corretta interpretazione, è necessario aver
+      installato texlive con i pacchetti amdfonts e amsmath.
+
+Riassumendo, se volete installare la versione 1.4.9 di Sphinx dovete eseguire::
+
+       $ virtualenv sphinx_1.4
+       $ . sphinx_1.4/bin/activate
+       (sphinx_1.4) $ pip install -r Documentation/sphinx/requirements.txt
+
+Dopo aver eseguito ``. sphinx_1.4/bin/activate``, il prompt cambierà per
+indicare che state usando il nuovo ambiente. Se aprite un nuova sessione,
+prima di generare la documentazione, dovrete rieseguire questo comando per
+rientrare nell'ambiente virtuale.
+
+Generazione d'immagini
+----------------------
+
+Il meccanismo che genera la documentazione del kernel contiene un'estensione
+capace di gestire immagini in formato Graphviz e SVG (per maggior informazioni
+vedere :ref:`it_sphinx_kfigure`).
+
+Per far si che questo funzioni, dovete installare entrambe i pacchetti
+Graphviz e ImageMagick. Il sistema di generazione della documentazione è in
+grado di procedere anche se questi pacchetti non sono installati, ma il
+risultato, ovviamente, non includerà le immagini.
+
+Generazione in PDF e LaTeX
+--------------------------
+
+Al momento, la generazione di questi documenti è supportata solo dalle
+versioni di Sphinx superiori alla 1.4.
+
+Per la generazione di PDF e LaTeX, avrete bisogno anche del pacchetto
+``XeLaTeX`` nella versione 3.14159265
+
+Per alcune distribuzioni Linux potrebbe essere necessario installare
+anche una serie di pacchetti ``texlive`` in modo da fornire il supporto
+minimo per il funzionamento di ``XeLaTeX``.
+
+.. _it_sphinx-pre-install:
+
+Verificare le dipendenze Sphinx
+-------------------------------
+
+Esiste uno script che permette di verificare automaticamente le dipendenze di
+Sphinx. Se lo script riesce a riconoscere la vostra distribuzione, allora
+sarà in grado di darvi dei suggerimenti su come procedere per completare
+l'installazione::
+
+	$ ./scripts/sphinx-pre-install
+	Checking if the needed tools for Fedora release 26 (Twenty Six) are available
+	Warning: better to also install "texlive-luatex85".
+	You should run:
+
+		sudo dnf install -y texlive-luatex85
+		/usr/bin/virtualenv sphinx_1.4
+		. sphinx_1.4/bin/activate
+		pip install -r Documentation/sphinx/requirements.txt
+
+	Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 468.
+
+L'impostazione predefinita prevede il controllo dei requisiti per la generazione
+di documenti html e PDF, includendo anche il supporto per le immagini, le
+espressioni matematiche e LaTeX; inoltre, presume che venga utilizzato un
+ambiente virtuale per Python. I requisiti per generare i documenti html
+sono considerati obbligatori, gli altri sono opzionali.
+
+Questo script ha i seguenti parametri:
+
+``--no-pdf``
+	Disabilita i controlli per la generazione di PDF;
+
+``--no-virtualenv``
+	Utilizza l'ambiente predefinito dal sistema operativo invece che
+	l'ambiente virtuale per Python;
+
+
+Generazione della documentazione Sphinx
+=======================================
+
+Per generare la documentazione in formato HTML o PDF si eseguono i rispettivi
+comandi ``make htmldocs`` o ``make pdfdocs``. Esistono anche altri formati
+in cui è possibile generare la documentazione; per maggiori informazioni
+potere eseguire il comando ``make help``.
+La documentazione così generata sarà disponibile nella sottocartella
+``Documentation/output``.
+
+Ovviamente, per generare la documentazione, Sphinx (``sphinx-build``)
+dev'essere installato. Se disponibile, il tema *Read the Docs* per Sphinx
+verrà utilizzato per ottenere una documentazione HTML più gradevole.
+Per la documentazione in formato PDF, invece, avrete bisogno di ``XeLaTeX`
+e di ``convert(1)`` disponibile in ImageMagick (https://www.imagemagick.org).
+Tipicamente, tutti questi pacchetti sono disponibili e pacchettizzati nelle
+distribuzioni Linux.
+
+Per poter passare ulteriori opzioni a Sphinx potete utilizzare la variabile
+make ``SPHINXOPTS``. Per esempio, se volete che Sphinx sia più verboso durante
+la generazione potete usare il seguente comando ``make SPHINXOPTS=-v htmldocs``.
+
+Potete eliminare la documentazione generata tramite il comando
+``make cleandocs``.
+
+Scrivere la documentazione
+==========================
+
+Aggiungere nuova documentazione è semplice:
+
+1. aggiungete un file ``.rst`` nella sottocartella ``Documentation``
+2. aggiungete un riferimento ad esso nell'indice (`TOC tree`_) in
+   ``Documentation/index.rst``.
+
+.. _TOC tree: http://www.sphinx-doc.org/en/stable/markup/toctree.html
+
+Questo, di solito, è sufficiente per la documentazione più semplice (come
+quella che state leggendo ora), ma per una documentazione più elaborata è
+consigliato creare una sottocartella dedicata (o, quando possibile, utilizzarne
+una già esistente). Per esempio, il sottosistema grafico è documentato nella
+sottocartella ``Documentation/gpu``; questa documentazione è divisa in
+diversi file ``.rst`` ed un indice ``index.rst`` (con un ``toctree``
+dedicato) a cui si fa riferimento nell'indice principale.
+
+Consultate la documentazione di `Sphinx`_ e `reStructuredText`_ per maggiori
+informazione circa le loro potenzialità. In particolare, il
+`manuale introduttivo a reStructuredText`_ di Sphinx è un buon punto da
+cui cominciare. Esistono, inoltre, anche alcuni
+`costruttori specifici per Sphinx`_.
+
+.. _`manuale introduttivo a reStructuredText`: http://www.sphinx-doc.org/en/stable/rest.html
+.. _`costruttori specifici per Sphinx`: http://www.sphinx-doc.org/en/stable/markup/index.html
+
+Guide linea per la documentazione del kernel
+--------------------------------------------
+
+In questa sezione troverete alcune linee guida specifiche per la documentazione
+del kernel:
+
+* Non esagerate con i costrutti di reStructuredText. Mantenete la
+  documentazione semplice. La maggior parte della documentazione dovrebbe
+  essere testo semplice con una strutturazione minima che permetta la
+  conversione in diversi formati.
+
+* Mantenete la strutturazione il più fedele possibile all'originale quando
+  convertite un documento in formato reStructuredText.
+
+* Aggiornate i contenuti quando convertite della documentazione, non limitatevi
+  solo alla formattazione.
+
+* Mantenete la decorazione dei livelli di intestazione come segue:
+
+  1. ``=`` con una linea superiore per il titolo del documento::
+
+       ======
+       Titolo
+       ======
+
+  2. ``=`` per i capitoli::
+
+       Capitoli
+       ========
+
+  3. ``-`` per le sezioni::
+
+       Sezioni
+       -------
+
+  4. ``~`` per le sottosezioni::
+
+       Sottosezioni
+       ~~~~~~~~~~~~
+
+  Sebbene RST non forzi alcun ordine specifico (*Piuttosto che imporre
+  un numero ed un ordine fisso di decorazioni, l'ordine utilizzato sarà
+  quello incontrato*), avere uniformità dei livelli principali rende più
+  semplice la lettura dei documenti.
+
+* Per inserire blocchi di testo con caratteri a dimensione fissa (codici di
+  esempio, casi d'uso, eccetera): utilizzate ``::`` quando non è necessario
+  evidenziare la sintassi, specialmente per piccoli frammenti; invece,
+  utilizzate ``.. code-block:: <language>`` per blocchi di più lunghi che
+  potranno beneficiare dell'avere la sintassi evidenziata.
+
+
+Il dominio C
+------------
+
+Il **Dominio Sphinx C** (denominato c) è adatto alla documentazione delle API C.
+Per esempio, un prototipo di una funzione:
+
+.. code-block:: rst
+
+    .. c:function:: int ioctl( int fd, int request )
+
+Il dominio C per kernel-doc ha delle funzionalità aggiuntive. Per esempio,
+potete assegnare un nuovo nome di riferimento ad una funzione con un nome
+molto comune come ``open`` o ``ioctl``:
+
+.. code-block:: rst
+
+     .. c:function:: int ioctl( int fd, int request )
+        :name: VIDIOC_LOG_STATUS
+
+Il nome della funzione (per esempio ioctl) rimane nel testo ma il nome del suo
+riferimento cambia da ``ioctl`` a ``VIDIOC_LOG_STATUS``. Anche la voce
+nell'indice cambia in ``VIDIOC_LOG_STATUS`` e si potrà quindi fare riferimento
+a questa funzione scrivendo:
+
+.. code-block:: rst
+
+     :c:func:`VIDIOC_LOG_STATUS`
+
+
+Tabelle a liste
+---------------
+
+Raccomandiamo l'uso delle tabelle in formato lista (*list table*). Le tabelle
+in formato lista sono liste di liste. In confronto all'ASCII-art potrebbero
+non apparire di facile lettura nei file in formato testo. Il loro vantaggio è
+che sono facili da creare o modificare e che la differenza di una modifica è
+molto più significativa perché limitata alle modifiche del contenuto.
+
+La ``flat-table`` è anch'essa una lista di liste simile alle ``list-table``
+ma con delle funzionalità aggiuntive:
+
+* column-span: col ruolo ``cspan`` una cella può essere estesa attraverso
+  colonne successive
+
+* raw-span: col ruolo ``rspan`` una cella può essere estesa attraverso
+  righe successive
+
+* auto-span: la cella più a destra viene estesa verso destra per compensare
+  la mancanza di celle. Con l'opzione ``:fill-cells:`` questo comportamento
+  può essere cambiato da *auto-span* ad *auto-fill*, il quale inserisce
+  automaticamente celle (vuote) invece che estendere l'ultima.
+
+opzioni:
+
+* ``:header-rows:``   [int] conta le righe di intestazione
+* ``:stub-columns:``  [int] conta le colonne di stub
+* ``:widths:``        [[int] [int] ... ] larghezza delle colonne
+* ``:fill-cells:``    invece di estendere automaticamente una cella su quelle
+  mancanti, ne crea di vuote.
+
+ruoli:
+
+* ``:cspan:`` [int] colonne successive (*morecols*)
+* ``:rspan:`` [int] righe successive (*morerows*)
+
+L'esempio successivo mostra come usare questo marcatore. Il primo livello della
+nostra lista di liste è la *riga*. In una *riga* è possibile inserire solamente
+la lista di celle che compongono la *riga* stessa. Fanno eccezione i *commenti*
+( ``..`` ) ed i *collegamenti* (per esempio, un riferimento a
+``:ref:`last row <last row>``` / :ref:`last row <it last row>`)
+
+.. code-block:: rst
+
+   .. flat-table:: table title
+      :widths: 2 1 1 3
+
+      * - head col 1
+        - head col 2
+        - head col 3
+        - head col 4
+
+      * - column 1
+        - field 1.1
+        - field 1.2 with autospan
+
+      * - column 2
+        - field 2.1
+        - :rspan:`1` :cspan:`1` field 2.2 - 3.3
+
+      * .. _`it last row`:
+
+        - column 3
+
+Che verrà rappresentata nel seguente modo:
+
+   .. flat-table:: table title
+      :widths: 2 1 1 3
+
+      * - head col 1
+        - head col 2
+        - head col 3
+        - head col 4
+
+      * - column 1
+        - field 1.1
+        - field 1.2 with autospan
+
+      * - column 2
+        - field 2.1
+        - :rspan:`1` :cspan:`1` field 2.2 - 3.3
+
+      * .. _`it last row`:
+
+        - column 3
+
+.. _it_sphinx_kfigure:
+
+Figure ed immagini
+==================
+
+Se volete aggiungere un'immagine, utilizzate le direttive ``kernel-figure``
+e ``kernel-image``. Per esempio, per inserire una figura di un'immagine in
+formato SVG::
+
+    .. kernel-figure::  ../../../doc-guide/svg_image.svg
+       :alt:    una semplice immagine SVG
+
+       Una semplice immagine SVG
+
+.. _it_svg_image_example:
+
+.. kernel-figure::  ../../../doc-guide/svg_image.svg
+   :alt:    una semplice immagine SVG
+
+   Una semplice immagine SVG
+
+Le direttive del kernel per figure ed immagini supportano il formato **DOT**,
+per maggiori informazioni
+
+* DOT: http://graphviz.org/pdf/dotguide.pdf
+* Graphviz: http://www.graphviz.org/content/dot-language
+
+Un piccolo esempio (:ref:`it_hello_dot_file`)::
+
+  .. kernel-figure::  ../../../doc-guide/hello.dot
+     :alt:    ciao mondo
+
+     Esempio DOT
+
+.. _it_hello_dot_file:
+
+.. kernel-figure::  ../../../doc-guide/hello.dot
+   :alt:    ciao mondo
+
+   Esempio DOT
+
+Tramite la direttiva ``kernel-render`` è possibile aggiungere codice specifico;
+ad esempio nel formato **DOT** di Graphviz.::
+
+  .. kernel-render:: DOT
+     :alt: foobar digraph
+     :caption: Codice **DOT** (Graphviz) integrato
+
+     digraph foo {
+      "bar" -> "baz";
+     }
+
+La rappresentazione dipenderà dei programmi installati. Se avete Graphviz
+installato, vedrete un'immagine vettoriale. In caso contrario, il codice grezzo
+verrà rappresentato come *blocco testuale* (:ref:`it_hello_dot_render`).
+
+.. _it_hello_dot_render:
+
+.. kernel-render:: DOT
+   :alt: foobar digraph
+   :caption: Codice **DOT** (Graphviz) integrato
+
+   digraph foo {
+      "bar" -> "baz";
+   }
+
+La direttiva *render* ha tutte le opzioni della direttiva *figure*, con
+l'aggiunta dell'opzione ``caption``. Se ``caption`` ha un valore allora
+un nodo *figure* viene aggiunto. Altrimenti verrà aggiunto un nodo *image*.
+L'opzione ``caption`` è necessaria in caso si vogliano aggiungere dei
+riferimenti (:ref:`it_hello_svg_render`).
+
+Per la scrittura di codice **SVG**::
+
+  .. kernel-render:: SVG
+     :caption: Integrare codice **SVG**
+     :alt: so-nw-arrow
+
+     <?xml version="1.0" encoding="UTF-8"?>
+     <svg xmlns="http://www.w3.org/2000/svg" version="1.1" ...>
+        ...
+     </svg>
+
+.. _it_hello_svg_render:
+
+.. kernel-render:: SVG
+   :caption: Integrare codice **SVG**
+   :alt: so-nw-arrow
+
+   <?xml version="1.0" encoding="UTF-8"?>
+   <svg xmlns="http://www.w3.org/2000/svg"
+     version="1.1" baseProfile="full" width="70px" height="40px" viewBox="0 0 700 400">
+   <line x1="180" y1="370" x2="500" y2="50" stroke="black" stroke-width="15px"/>
+   <polygon points="585 0 525 25 585 50" transform="rotate(135 525 25)"/>
+   </svg>
diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
index 7613a9f9e6f9..dae01886b073 100644
--- a/Documentation/translations/it_IT/index.rst
+++ b/Documentation/translations/it_IT/index.rst
@@ -83,6 +83,11 @@ sviluppatori che contribuiscono ogni anno. Come in ogni grande comunità,
 sapere come le cose vengono fatte renderà il processo di integrazione delle
 vostre modifiche molto più semplice
 
+.. toctree::
+   :maxdepth: 2
+
+   doc-guide/index
+
 .. warning::
 
     TODO ancora da tradurre
-- 
2.14.4
